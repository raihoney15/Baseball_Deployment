Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  # devise_scope :user do
  #   get 'users/confirmation', to: 'users/confirmations#show'
  # end
  
  # mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

end
