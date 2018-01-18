Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :recipes do
    collection do
      get :search
      get :favorites
      get :my
    end
    
    member do 
      post :favorite
      delete :unfavorite, to: 'recipes#unfavorite'   
      post :share
    end
  end
  resources :cuisines, only: [:show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:show, :new, :create]
end

