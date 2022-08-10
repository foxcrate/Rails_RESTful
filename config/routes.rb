Rails.application.routes.draw do
  resources :lessons
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :contacts
      resources :books , only: [:index, :create, :destroy]
      get '/books/teto', to: 'books#teto'
      
      post '/authentication/sign_up', to: 'authentication#sign_up'
      # post '/authentication/sign_in', to: 'authentication#sign_in'
      
      post '/authentication/token_sign_up', to: 'authentication#token_sign_up'
      post '/authentication/token_sign_in', to: 'authentication#token_sign_in'

      get '/students/get_courses', to: 'students#get_courses'
      get '/courses/get_students', to: 'courses#get_students'
      post '/students/add_courses', to: 'students#add_courses'
      post '/courses/add_students', to: 'courses#add_students'
    end
  end

end
