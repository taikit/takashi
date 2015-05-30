Rails.application.routes.draw do
  resources :areas
  resources :categories
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  resources :plans do
    resources :bookings ,:only => [:new, :create]
  end
  root 'static_pages#index'
end
