Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#show'
  get '/auth/github', as: :github_login
  get '/auth/github/callback', to: 'sessions#create'
  get '/logout', as: :logout, to: "sessions#destroy"

end
