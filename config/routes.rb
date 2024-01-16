Rails.application.routes.draw do
  resources :roosters
  resources :teams
  resources :tournaments
  root 'pages#home'
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }



end
