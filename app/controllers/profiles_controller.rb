class ProfilesController < ApplicationController
    before_action :profile_params, only: [:update]
    before_action :set_user, only: [:show, :edit, :update]
 
    def show
    #  @favorites_podcasts = @user.favorite_podcasts
    #  @listening_histories = @user.listening_histories
    #  @user_recommendations = @user.user_recommendations
    end
 
    def edit
    end
 
    def update
      ActiveRecord::Base.transaction do
        @user.update!(profile_params)
        update_user_genres
        redirect_to profile_path, notice: 'Profile was successfully updated.'
      rescue ActiveRecord::RecordInvalid => e
        flash.now[:alert] = "Update failed: #{e.message}"
        render :edit, status: :unprocessable_entity
      rescue => e # Catch other unexpected exceptions
        flash.now[:alert] = "An unexpected error occurred: #{e.message}"
        render :edit, status: :internal_server_error
      end
    end
 
    private
 
    def set_user
     @user = current_user
    end
 
    def profile_params
     params.require(:user).permit(:preferred_podcast_length, :language, genre_ids: [])
    end

    def update_user_genres
      @user.user_genres.destroy_all
      genre_ids = params[:user][:genre_ids] || []
      genre_ids.each do |genre_id|
        @user.user_genres.create!(genre_id: genre_id)
      end
    end
 end
 