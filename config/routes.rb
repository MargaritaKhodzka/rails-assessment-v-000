Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :destinations do
    resources :notes
    resources :visited, only: :create
  end

  resources :categories

  authenticated :user do
    root to: 'destinations#index', as: :authenticated_root
  end

  root 'destinations#index'

end
