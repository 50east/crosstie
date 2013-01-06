Crosstie::Application.routes.draw do

  # Sessions
  get '/login'  => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  resources :sessions, only: [ :create ]

  root to: 'pages#home'
end
