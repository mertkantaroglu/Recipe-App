Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  patch 'recipes/:id/update_public', to: 'recipes#update_public', as: 'recipe_update_public'

  resources :foods

  resources :users, only: %i[index show] do
    resources :foods, only: %i[index new create destroy]
  end

  resources :recipes, only: %i[index show new create destroy] do
    patch :update_public, on: :member
  end

  resources :recipes do
    resources :shopping_lists, only: [:index]
  end

  resources :shopping_lists, only: [:index]
  resources :public_recipes, only: [:index]
  resources :recipe_foods, only: %i[create new destroy], path: 'recipe_foods'
end
