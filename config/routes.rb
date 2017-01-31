Rails.application.routes.draw do
  get 'authenticate', to: 'authentication#authenticate'

  root to: 'application#hello'

  resources :donations do
    member do
      post 'approve'
    end
  end

  resource :user, only: %w(show)
end
