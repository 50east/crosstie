Crosstie::Application.routes.draw do

  # Sessions
  get '/login'  => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  resources :sessions, only: [ :create ]

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root to: 'welcome#index'
end
