Rails.application.routes.draw do
  get 'authenticate', to: 'authentication#authenticate'

  root to: 'application#hello'

  resources :donations
  resource :user, only: %w(show)
end
