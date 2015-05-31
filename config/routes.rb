Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  resources :plans do
    resources :day, :only => [] do
      resources :bookings, :only => [:new, :create]
    end
  end

  namespace :admin do
    resources :areas
    resources :categories
  end
  root 'static_pages#index'
end
