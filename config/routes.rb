Rails.application.routes.draw do
  resources :bookings
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  resources :plans

  root 'static_pages#index'

end
