module PodcastsHelper
  def already_liked?(podcast)
    Like.where(user_id: current_user.id, podcast_id: podcast.id).exists?
  end

  def find_like(podcast)
    Like.find_by(user_id: current_user.id, podcast_id: podcast.id)
  end

  def genres_name(podcast)
    Genre.where(listen_notes_genre_id: podcast.genres).pluck(:name).join(', ')
  end
end
