require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  mount Sidekiq::Web => '/sidekiq'

  resources :donations, except: %i(destroy) do
    member do
      post 'approve'
      get 'receipt'
    end
  end

  resources :users, only: %i(show edit update)
  resources :volunteers, only: %w(index new create edit update)
  resources :coaches, only: %w(index new create edit update)
  resources :fellows, only: %w(index new create edit update)
  resources :national_finance_heads, only: %w(index)
  resources :cities, only: %w(index new create)

  root to: 'home#index'
end
