Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :destinations do
    resources :categories, only: %i[index create new edit show]
  end

  resources :categories

  root 'welcome#home'

  authenticated :user do
    root to: 'destinations#index', as: :authenticated_root
  end

  get '/visited_destinations', to: 'users#user_visited'

  get '/destinations/:id/next', to: 'destinations#next'

end
