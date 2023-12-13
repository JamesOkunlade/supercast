namespace :podcast_recommendations do
  desc 'Generate personalized podcast recommendations'
  task generate: :environment do
    # Fetch user preferences from the database by taking user_genres, language, and preferred_podcast_length
    all_user_genres = UserGenre.pluck(:genre_id).uniq
    listen_notes_genre_ids = Genre.where(id: all_user_genres).pluck(:listen_notes_genre_id).join(',')

    all_languages = User.pluck(:language).compact.uniq

    min_podcast_length = User.pluck(:preferred_podcast_length).min
    max_podcast_length = User.pluck(:preferred_podcast_length).max

    api_key = ENV['LISTEN_NOTES_API_KEY']
    service = ListenNotesService.new(api_key)

    service.fetch_and_update_podcasts(
        'Family and Career',
        type: 'episode', 
        offset: 0, 
        len_min: min_podcast_length, 
        len_max: max_podcast_length, 
        genre_ids: listen_notes_genre_ids, 
        language: 'English', 
        page_size: 10
    )
  end
end
