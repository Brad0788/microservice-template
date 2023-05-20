Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      scope :users do
        get '/', to: 'users#index'
        post '/', to: 'users#create'
        get '/:id', to: 'users#show'
        patch '/:id', to: 'users#update'
        put '/:id', to: 'users#update'
        delete '/:id', to: 'users#destroy'
      end
    end
  end
end
