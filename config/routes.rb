Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :competitions

  namespace :admin do
    root to: 'home#index', as: :root
    resources :athletes
    resources :tournaments, expect: [:show]
  end
end
