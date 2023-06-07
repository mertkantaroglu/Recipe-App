Rails.application.routes.draw do
  resources :foods
  devise_for :users
  root 'foods#index'

  get '/shopping_lists', to: 'shopping_lists#index'

  resources :users, only: [:index, :show] do
    resources :foods, only: %i[index new create destroy]
  end

  resources :recipes, only: %i[index show new create destroy] do
    resources :recipe_foods
  end

  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]
end
