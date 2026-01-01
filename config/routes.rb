Rails.application.routes.draw do
  root "pages#hero_section"
  resource :session, except: [ :new ]
  resource :registrations, only: [ :new, :create ]
  resource :users, except: [ :new ]
  # get '/signup', to: "registrations#new", as: :new_registrations
  # post 'registration/create', to: "registrations#create", as: :registrations
  get "/login", to: "sessions#new", as: :new_session
  resources :passwords, param: :token
  get "/home", to: "pages#hero_section"
  get "/about", to: "pages#about"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
