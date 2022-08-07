Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :books , only: [:index, :create, :destroy]
      get '/books/teto', to: 'books#teto'
      
      post '/authentication/sign_up', to: 'authentication#sign_up'
      post '/authentication/sign_in', to: 'authentication#sign_in'
      
      post '/authentication/token_sign_up', to: 'authentication#token_sign_up'
      post '/authentication/token_sign_in', to: 'authentication#token_sign_in'
    end
  end

end
