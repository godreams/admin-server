Rails.application.routes.draw do
  get 'authenticate', to: 'authentication#authenticate'

  root to: 'application#hello'
end
