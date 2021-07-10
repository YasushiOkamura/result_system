# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index", as: :root
  resources :tournaments, only: %i[index show]
  get "/ranking", to: "ranking#index", as: "ranking"
  get "/search", to: "search#index", as: "search"

  resources :athletes, only: %i[index show] do
    member do
      get "graph"
    end
  end

  namespace :admin do
    root to: "home#index", as: :root
    get "login", to: "sessions#new", as: :new_session
    post "login", to: "sessions#create", as: :session
    delete "logout", to: "sessions#destroy", as: :destroy_session

    resources :competitions
    resources :athletes
    resources :tournaments
    resources :short_results
    resources :long_results
    resources :field_results
    resources :relay_results
    resources :road_results
    resources :decathlon_results
    resources :ekidens do
      resources :raps do
        post :broadcast, to: "raps#broadcast"
      end
      resources :kukans
      resources :points
    end
  end

  get "/mentenance", to: "mentenance#index", as: "mentenance"
  root "errors#routing_error"
  get "*anything" => "errors#routing_error"
end
