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
        @user.update(profile_params)
        @user.user_genres.destroy_all
        params[:user][:genre_ids].each do |genre_id|
          UserGenre.create(user_id: @user.id, genre_id: genre_id)
        end
        redirect_to profile_path, notice: 'Profile was successfully updated.'
      rescue ActiveRecord::RecordInvalid
        render :edit
      end
    end
 
    private
 
    def set_user
     @user = current_user
    end
 
    def profile_params
     params.require(:user).permit(:preferred_podcast_length, :language)
    end
 end
 