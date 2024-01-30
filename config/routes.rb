Rails.application.routes.draw do

  resources :tournaments do
    resources :teams do
      resources :roosters
    end
  end
  
 
  root 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:index]
   
  
end


