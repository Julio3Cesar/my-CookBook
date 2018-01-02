Rails.application.routes.draw do
  root to: 'home#index'
  resources :recipe, only: [:show, :new, :create]
  resources :cuisine, only: [:show, :new, :create]
  resources :recipe_type, only: [:show]
end

