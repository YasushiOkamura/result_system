Rails.application.routes.draw do
  root to: 'home#index', as: :root
  resources :tournaments, only: [:index, :show]
  get '/ranking', to: 'ranking#index', as: 'ranking'
  get '/search', to: 'search#index', as: 'search'

  resources :athletes, only: [:index, :show]

  namespace :admin do
    root to: 'home#index', as: :root
    get 'login', to: 'sessions#new',  as: :new_session
    post 'login', to: 'sessions#create', as: :session
    delete 'logout', to: 'sessions#destroy', as: :destroy_session

    resources :competitions
    resources :athletes
    resources :tournaments
    resources :short_results
    resources :long_results
    resources :field_results
    resources :relay_results
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end
