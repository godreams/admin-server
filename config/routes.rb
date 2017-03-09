require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
  end

  mount Sidekiq::Web => '/sidekiq'

  scope '/api' do
    get 'authenticate', to: 'authentication#authenticate'

    resources :donations do
      member do
        post 'approve'
        get 'receipt'
      end
    end

    resource :user, only: %w(show)

    resources :users, only: [] do
      collection do
        get 'find'
      end
    end

    resources :volunteers, only: %w(index create)
    resources :coaches, only: %w(index create)
    resources :fellows, only: %w(index create)
  end

  root to: 'home#index'
end
