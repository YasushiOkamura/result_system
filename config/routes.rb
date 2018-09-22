Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    root to: 'home#index', as: :root
    resources :competitions
    resources :athletes
    resources :tournaments
    resources :short_results
  end
end
