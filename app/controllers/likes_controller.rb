class LikesController < ApplicationController
  before_action :find_podcast, only: [:create, :destroy]
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @podcast.likes.create(user_id: current_user.id)
    end
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
  end

  private

  def find_podcast
    @podcast = Podcast.find(params[:podcast_id])
  end

  def find_like
    @like = @podcast.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, podcast_id: params[:podcast_id]).exists?
  end
end
