Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  resources :games do
    resources :guesses, only: [:create]
  end
end
