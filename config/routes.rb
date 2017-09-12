Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :destinations do
    resources :categories, only: [:show, :create, :destroy]
  end

  resources :users, only: [:show]

  get '/visited_destinations', to: 'users#user_visited'


end