class PodcastsController < ApplicationController
  def index;end

  def user_specific
    # logic to load genre-related podcasts
    listen_notes_genre_ids = current_user.genres.pluck(:listen_notes_genre_id)
    @genre_related_podcasts = Podcast.where('genres && ARRAY[?]::integer[]', listen_notes_genre_ids).includes(:likes).all

    # render partial: 'user_specific_podcasts'
    render 'user_specific_podcasts'

  end
  
  def explore
    # logic to load all podcasts
    @podcasts = Podcast.includes(:likes).all

    # render partial: 'explore_podcasts'
    render 'explore_podcasts'

  end
  
  def library
    # logic to load user preferences
    # render partial: 'library_podcasts'
    render 'library_podcasts'
  end

  def show
    @podcast = Podcast.find(params[:id])
  end

end
