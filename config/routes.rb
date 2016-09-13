Rails.application.routes.draw do
  # REVIEW: Not required unless specifically referenced
  get 'welcome/index'

  root 'welcome#index'

  # REVIEW: Restrict actions for game to only those that are used
  resources :games do
    resources :guesses, only: [:create]
  end
end
