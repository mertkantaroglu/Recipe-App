require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.create(name: 'Jonas', email: 'jnw@gmail.com', password: 'jonas123')
    @food = Food.new(name: 'Burger', measurement_unit: 'grams', price: 10, quantity: 2, user_id: subject.id)
    @recipe = Recipe.new(user_id: subject.id, name: 'Burger', preparation_time: 20, cooking_time: 50, description: 'Home style american burger', public: true)
    @recipe_food = RecipeFood.new(recipe: @recipe, food: @food, quantity: 2)
  end

  describe 'Testing validations' do
    it 'validation should be successful' do
      expect(@recipe_food).to be_valid
    end

    it 'should have a food' do
      expect(@recipe_food.food).to be_present
    end

    it 'should have a valid food id' do
      @recipe_food.food = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'should have a recipe' do
      expect(@recipe_food.recipe).to be_present
    end

    it 'should have a valid recipe id' do
      @recipe_food.recipe = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'should have a quantity' do
      expect(@recipe_food.quantity).to eql 2
    end
  end

  describe 'Testing associations' do
    it 'recipe food should belong to a recipe' do
      @recipe_food = RecipeFood.reflect_on_association(:recipe)
      expect(@recipe_food.macro).to eql(:belongs_to)
    end

    it 'recipe food should belong to a food' do
      @recipe_food = RecipeFood.reflect_on_association(:food)
      expect(@recipe_food.macro).to eql(:belongs_to)
    end
  end
end
