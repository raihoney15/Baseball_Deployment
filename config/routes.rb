Rails.application.routes.draw do

  resources :tournaments do
    get 'search', on: :collection
  end
  
  resources :tournaments do
    resources :teams do
      resources :roosters
    end
  end

  resources :tournaments do
    resources :opponent_teams do
      resources :opponent_roosters
    end
  end

  resources :tournaments do
    resources :events do
      resources :team_line_ups
      resources :opponent_team_line_ups
    end
  end

  resources :tournaments do
    resources :events do
      get 'start', on: :member
    end
  end

 
  root 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "/verify" => "verify#edit", :as => "verify"
  get "/verify" => "verify#new", :as => "new_verify"
  put "/verify" => "verify#update", :as => "update_verify"
  post "/verify" => "verify#create", :as => "resend_verify"
  resources :users, only: [:index,:destroy]
  
end

