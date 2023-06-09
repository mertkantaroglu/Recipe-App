Rails.application.routes.draw do
  resources :foods
  devise_for :users
  root 'foods#index'

  get '/shopping_lists', to: 'shopping_lists#index'

  patch 'recipes/:id/update_public', to: 'recipes#update_public', as: 'recipe_update_public'

  resources :users, only: %i[index show] do
    resources :foods, only: %i[index new create destroy]
  end

  resources :recipes, only: %i[index show new create destroy] do
    patch :update_public, on: :member
  end

  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]
  resources :recipe_foods, only: %i[create new destroy], path: 'recipe_foods'
end
