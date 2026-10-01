Rails.application.routes.draw do
  # resources :trackers
  root "pages#hero_section"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :dry_foods, only: [ :new, :create, :index, :destroy, :show ] do
      member do
        get :restock
        patch :restock
      end
    end
    resources :pets do
      resource :share, only: [ :create, :destroy ], controller: "pet_shares"
      resources :medications, only: %i[index create update destroy]
      resources :health_checks do
        collection do
          delete :bulk_delete
          post :extract_data
        end
      end
      resources :trackers do
        collection do
          post :import
          get "favorite_food"
          delete :bulk_delete
        end
      end
      resources :vet_visits do
        collection do
          patch :batch_update
        end
      end
      resources :kibble_prices, only: [ :index, :create ]
    end
    get "shared/:share_token", to: "shared_trackers#show", as: :shared_pet_trackers
    # The owner's household: members, caregiver invitations, viewer links.
    resource :household, only: :show do
      resources :invitations, only: %i[create destroy], controller: "household_invitations"
      resources :viewer_links, only: %i[create destroy]
      resources :members, only: :destroy, controller: "household_members"
      resources :ownership_transfers, only: %i[create destroy]
      resources :care_spots, only: %i[create update destroy] do
        patch :move, on: :member
      end
      resource :care_records, only: :show
    end
    # An invited caregiver joins from the link in their invitation email.
    get "join/:token", to: "household_joins#show", as: :join_household
    post "join/:token", to: "household_joins#create"
    # A viewer's personal read-only page (no account needed).
    get "view/:token", to: "viewer_pages#show", as: :viewer_page
    post "view/:token", to: "viewer_pages#create"
    delete "households/:household_id/leave", to: "household_memberships#destroy", as: :leave_household
    patch "households/:household_id/reminders", to: "reminder_settings#update", as: :household_reminders
    get "today", to: "today#show", as: :today
    resources :care_events, only: %i[create edit update destroy] do
      post :undo, on: :member
    end
    # The member a household was offered to accepts it.
    resources :ownership_transfer_offers, only: %i[show update], path: "transfers"
    resource :session, except: [ :new ]
    delete "session/others", to: "sessions#destroy_others", as: :other_sessions
    resource :registrations, only: [ :new, :create ]
    resource :timezone, only: [ :create ]
    resource :users, except: [ :new ]
    # get '/signup', to: "registrations#new", as: :new_registrations
    # post 'registration/create', to: "registrations#create", as: :registrations
    get "/login", to: "sessions#new", as: :new_session
    resources :passwords, only: [ :new, :create, :edit, :update ], param: :token
    get "/home", to: "pages#hero_section"
    get "/about", to: "pages#about"
    get "/doc", to: "pages#doc"
    get "/privacy", to: "pages#privacy"
    get "/terms", to: "pages#terms"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "auth/:provider/callback", to: "omni_auth/sessions#create"
  post "auth/:provider/callback", to: "omni_auth/sessions#create"
  get "auth/failure", to: "omni_auth/sessions#failure"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
