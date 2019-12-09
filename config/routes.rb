Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  resources :friendships, only: [:create]

  get 'auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'users/github_info#show'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/invite', to: 'invitations#new'
  post '/invite', to: 'invitations#create'

  resources :users, only: [:new, :create, :update, :edit]

  # resend activation link route
  get '/users/:id/activation/new', to: 'users/activation#new', as: 'activation_new'

  # link inside email body to activate account
  get '/users/:id/activation', to: 'users/activation#update', as: 'activation'

  # thank you for updating
  get '/users/:id/activation/activated', to: 'users/activation#show'


  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]
end
