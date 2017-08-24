Rails.application.routes.draw do

  root to: 'home#index'

  get 'home/about'
  get 'home/index'
  get 'home/contact'
  get 'home/service'
  get 'dashboard/timeline'

  get 'dashboard/servicemen_list'
  get 'dashboard/plumbers_list'
  get 'dashboard/electricians_list'
  get 'dashboard/carpenters_list'
  get 'dashboard/cleaners_list'


  devise_for :users


  resources :users
  resources :services do
    member do
      get :accept_request
      get :cancel_request
      get :complete_request
    end
    collection do
      get :accepted_request
      get :cancelled_request
      get :completed_request
      get :user_profile
    end
  end

  # devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' } do
  #   get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  # end


end
