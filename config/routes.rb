Rails.application.routes.draw do
  scope '/api' do
    get 'authenticate', to: 'authentication#authenticate'

    resources :donations do
      member do
        post 'approve'
      end
    end

    resource :user, only: %w(show)
    resources :volunteers, only: %w(index create)
  end

  match '*path', to: 'client#index', via: :all
end
