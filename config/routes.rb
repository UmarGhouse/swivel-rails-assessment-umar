Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  # Setup devise user routes and override registrations controller
  devise_for :users, skip: ['sessions'], controllers: {
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do    
      resources :courses
      resources :categories
      resources :verticals
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
