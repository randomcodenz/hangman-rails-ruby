Rails.application.routes.draw do
  root 'welcome#index'

  resources :games, only: [:create, :show] do
    resources :guesses, only: [:create]
  end
end
