Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  namespace :admin do
    resources :users
  end

  resources :tasks do 
    collection do
      get 'search' => "tasks#search"
    end
  end
  root :to => 'tasks#index'
end
