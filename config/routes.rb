Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :recipes, only: [:show, :new, :create, :edit, :update, :destroy, :index] do
    collection do
      get :search
      get :favorites
    end
    
    member do 
      post :favorite
      delete :unfavorite, to: 'recipes#unfavorite'   
    end
  end
  resources :cuisines, only: [:show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:show, :new, :create]
end

