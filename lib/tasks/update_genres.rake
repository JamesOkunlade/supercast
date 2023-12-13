namespace :genres do
  task update: :environment do
    api_key = ENV['LISTEN_NOTES_API_KEY']
    service = ListenNotesService.new(api_key)

    service.fetch_and_update_genres
  end
end
  