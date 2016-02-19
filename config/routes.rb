Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:show]

  get 'welcome/index'

  root 'welcome#index'

  resources 'search'
  
  resource 'playlist'

  resources :playlists do
    collection do
      get 'assign_user'
    end
  end
end
