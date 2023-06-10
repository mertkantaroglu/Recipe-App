class ShoppingListsController < ApplicationController
  def index
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @shopping_lists = @recipe.recipe_foods.includes(:food)
    @sum = calculate_sum(@shopping_lists)
    @total_count = @shopping_lists.size
  end

  private

  def calculate_sum(shopping_lists)
    sum = 0
    shopping_lists.each do |shopping_list|
      sum += shopping_list.quantity * shopping_list.food.price
    end
    sum
  end
end
