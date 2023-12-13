require 'podcast_api'
require 'time'

class ListenNotesService
  def initialize(api_key)
    @client = PodcastApi::Client.new(api_key: api_key)
  end

  # Genres search
  def fetch_and_update_genres
    # In the absence of redis, we can use Rails.cache to cache the data.
    # Data is lost after server restart though.
    genres_data = Rails.cache.fetch("genres_data", expires_in: 24.hours) do
      response = @client.fetch_podcast_genres(top_level_only: 1)
      parsed_data = JSON.parse(response.body)
      parsed_data['genres']
    end

    genres_data.each do |genre_data|
      Genre.find_or_create_by(listen_notes_genre_id: genre_data['id']) do |genre|
        genre.listen_notes_genre_id = genre_data['id']
        genre.name = genre_data['name']
      end
    end
  end

  # Podcasts search
  def search_podcasts(query, options = {})
    @client.search( 
        q: query,
        type: options[:type],
        offset: options[:offset],
        len_min: options[:len_min],
        len_max: options[:len_max],
        genre_ids: options[:genre_ids],
        only_in: options[:only_in],
        language: options[:language],
        page_size: options[:page_size],
    )
  end

  def fetch_and_update_podcasts(query, options = {})
    with_retries do
      response = search_podcasts(query, options)
      if response.success?
        process_podcasts(response.body)
      end

      check_rate_limit(response)
      log_api_metrics(response)
    rescue PodcastApi::AuthenticationError => e
      handle_error("Wrong API key: #{e.message}")
    rescue PodcastApi::InvalidRequestError => e
      handle_error("Client side errors: #{e.message}")
    rescue PodcastApi::NotFoundError => e
      handle_error("Not found: #{e.message}")
    rescue PodcastApi::RateLimitError => e
      handle_error("Rate limit exceeded: #{e.message}")
    rescue PodcastApi::PodcastApiError => e
      handle_error("Server side error: #{e.message}")
    end
  end


  def process_podcasts(response_data)
    parsed_data = JSON.parse(response_data)
    podcasts_data = parsed_data['results']

    podcasts_data.each do |podcast_data|
      Podcast.find_or_create_by(listen_notes_podcast_id: podcast_data['podcast']['id']) do |podcast|
        podcast.listen_notes_podcast_id = podcast_data['podcast']['id']
        podcast.title = podcast_data['podcast']['title_original']
        podcast.description = podcast_data['description_original']
        podcast.duration = podcast_data['audio_length_sec']
        podcast.host = podcast_data['podcast']['publisher_original']
        podcast.audio_url = podcast_data['audio']
        podcast.thumbnail_url = podcast_data['podcast']['thumbnail']
        podcast.genres = podcast_data['podcast']['genre_ids']

        podcast.save!
      end
    end
  end

  def handle_error(message)
    Rails.logger.info message
  end

  def log_api_metrics(response)
    Rails.logger.error "Free Quota per month: #{response.headers['X-ListenAPI-FreeQuota']}"
    Rails.logger.error "Usage this month: #{response.headers['X-ListenAPI-Usage']}"
    Rails.logger.error "Next billing date: #{response.headers['X-Listenapi-NextBillingDate']}"
  end

  def check_rate_limit(response)
    free_quota = response.headers['X-ListenAPI-FreeQuota'].to_i
    usage = response.headers['X-ListenAPI-Usage'].to_i
    if free_quota - usage < 10
      sleep_time = calculate_sleep_time(response)
      sleep(sleep_time)
    end
  end

  def with_retries(max_attempts: 5)
    attempts = 0
    begin
      yield
    rescue PodcastApi::APIConnectionError => e
      attempts += 1
      if attempts < max_attempts
        sleep(2**attempts)
        retry
      else
        raise e
      end
    end
  end

  def calculate_sleep_time(response)
    next_billing_date = Time.parse(response.headers['X-Listenapi-NextBillingDate'])
    current_time = Time.now
    sleep_time = next_billing_date - current_time
    sleep_time.positive? ? sleep_time : 0
  end
end
