require 'rails_helper'

RSpec.describe 'recipe_foods/index', type: :feature do
  describe 'after log in' do
    before(:each) do
      @user = User.create(name: 'Jonas', email: 'jonasnw@gmail.com', password: 'jonas123', confirmed_at: Time.now)
      @recipe = Recipe.create(user_id: @user.id, name: 'Burger', preparation_time: 20, cooking_time: 50, description: 'Home style american burger', public: true)

      visit 'users/sign_in'
      fill_in 'Email', with: 'jonasnw@gmail.com'
      fill_in 'Password', with: 'jonas123'
      click_on 'Log in'

      visit "/recipes/#{@recipe.id}"
    end

    it 'displays the recipe name' do
      expect(page).to have_content(@recipe.name)
    end

    it 'displays the preparation_time' do
      expect(page).to have_content(@recipe.preparation_time.to_i)
    end

    it 'displays the cooking_time' do
      expect(page).to have_content(@recipe.cooking_time.to_i)
    end

    it 'displays the food items' do
      expect(page).to have_content 'Food'
    end

    it 'displays the quantity of the items' do
      expect(page).to have_content 'Quantity'
    end

    it 'displays the value of the items' do
      expect(page).to have_content 'Value'
    end

    it 'displays the generate_shopping_list button' do
      expect(page).to have_content 'Generate shopping list'
    end

    it 'displays the add ingredient button' do
      expect(page).to have_content 'Add ingredient'
    end
  end
end
