Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "podcasts#index"
  root "podcasts#user_specific"

  resources :podcasts, only: [:index, :show] do
    collection do
      get 'user_specific'
      get 'explore'
      get 'library'
    end
    resources :likes, only: [:create, :destroy]
  end
  
  resource :profile, only: [:show, :edit, :update]
end
