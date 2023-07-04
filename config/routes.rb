Rails.application.routes.draw do
  resources :tasks do 
    collection do
      get 'search' => "tasks#search"
    end
  end
  root :to => 'tasks#index'
end
