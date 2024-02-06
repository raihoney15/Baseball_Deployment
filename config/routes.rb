Rails.application.routes.draw do

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
    resources :events
  end

  resources :events do
    resources :team_lineups
    resources :opponent_team_lineups
  end
 
  root 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "/verify" => "verify#edit", :as => "verify"
  get "/verify" => "verify#new", :as => "new_verify"
  put "/verify" => "verify#update", :as => "update_verify"
  post "/verify" => "verify#create", :as => "resend_verify"
  resources :users, only: [:index]
  
end


