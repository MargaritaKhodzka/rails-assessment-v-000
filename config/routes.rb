Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :destinations do
    resources :categories, only: %i[index create new edit show]
  end

  resources :categories

  authenticated :user do
    root to: 'destinations#index', as: :authenticated_root
  end

  root 'welcome#home'
  get '/visited_destinations', to: 'users#user_visited'

end
