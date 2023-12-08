namespace :genres do
  task update: :environment do
    # api_key = ENV['LISTEN_NOTES_API_KEY']
    api_key = '88f5c30deccc44a4a6ef2f74f71f6d84'
    service = ListenNotesService.new(api_key)

    service.fetch_and_update_genres
  end
end
  