Rails.application.routes.draw do
  root to: 'home#index'
  # get'*path', to: 'home#index'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :zones, only: [:index, :show, :update, :destroy, :create]
    end
  end

end
