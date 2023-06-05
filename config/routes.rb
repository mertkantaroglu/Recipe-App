Rails.application.routes.draw do
  root 'foods#index'

  resources :users
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_foods
  end

  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]
end
