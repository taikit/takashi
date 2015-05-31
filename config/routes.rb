Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  resources :plans do
    resources :days, :only => [] do
      resources :bookings, :only => [:new, :create]
    end
  end

  resources :users, only: [:edit, :update, :index]

  get '/plans/area/:area_name', to: 'plans#index', as: 'area_plans'
  get '/plans/category/:category_name', to: 'plans#index', as: 'category_plans'

  namespace :admin do
    resources :areas
    resources :categories
  end
  root 'static_pages#index'
end
