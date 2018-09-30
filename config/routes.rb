Rails.application.routes.draw do
  root to: 'home#index', as: :root
  resources :tournaments, only: [:index, :show]

  namespace :admin do
    root to: 'home#index', as: :root
    resources :competitions
    resources :athletes
    resources :tournaments
    resources :short_results
    resources :long_results
    resources :field_results
    resources :relay_results
  end
end
