Rails.application.routes.draw do
  devise_for :users

  resources :feedbacks
  resources :relationships
  resources :users do
  	member do
  		get :following, :followers
  	end
  end
  resources :posts do
    resources :comments
  end
  resources :jobs
  resources :rankings
  resources :pages
  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  root 'pages#landing'

  get '/landing' => 'pages#landing'
  get '/home' => 'pages#home'
  get '/explore' => 'pages#explore'
  get '/index' => 'pages#index'
  get '/redirect' => 'pages#redirect'
  get '/messages' => 'messages#index'
  get '/autocompleteJobs' => 'pages#autocompleteJobs'
  get '/autocompleteLocation' => 'pages#autocompleteLocation'
  get '/autocompletePosition' => 'pages#autocompletePosition'

  # For custom jobs index paths
  post '/jobs/new' => 'jobs#create'
  post '/rankings/new' => 'rankings#new'
end
