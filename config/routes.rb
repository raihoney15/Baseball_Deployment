Rails.application.routes.draw do
  # resources :roosters
  # resources :teams 
    # resources :users
  # resources :tournaments do 
  #   resources :teams do 
  #     resources :roosters
  #   end 
  # end
  resources :tournaments 
  resources :teams 
  resources :roosters
 
  root 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:index]
   
  
end
