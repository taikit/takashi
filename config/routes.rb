Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  resources :plans do
    resources :bookings ,:only => [:new, :create]
  end

  namespace :admin do
    resources :areas
    resources :categories
  end
  root 'static_pages#index'
end
