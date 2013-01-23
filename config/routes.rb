Crosstie::Application.routes.draw do

  # Sessions
  get '/login'  => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  resources :sessions, only: [ :create ]

  get '/forgot-password' => 'registrations#forgot_password'
  post '/reset-password' => 'registrations#reset_password'

  root to: 'pages#home'
end
