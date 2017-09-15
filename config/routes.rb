Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :destinations do
    resources :categories, only: %i[index create new edit show]
  end

  resources :users, only: [:show]

  resources :categories do
    resources :destinations, only: %i[index create new edit show]
  end

  authenticated :user do
    root to: 'destinations#index', as: :authenticated_root
  end

  root 'welcome#home'
  get 'visited', to: 'welcome#visited'

end
