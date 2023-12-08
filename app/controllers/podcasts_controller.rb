class PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all

    listen_notes_genre_ids = current_user.genres.pluck(:listen_notes_genre_id)
    @genre_related_podcasts = Podcast.where('genres && ARRAY[?]::integer[]', listen_notes_genre_ids)
  end
end
