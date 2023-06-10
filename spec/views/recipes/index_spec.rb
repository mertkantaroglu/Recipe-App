require 'rails_helper'

RSpec.describe 'recipes/index', type: :feature do
  describe 'after log in' do
    before(:each) do
      @user = User.create(name: 'Jonas', email: 'jonasnw@gmail.com', password: 'jonas123', confirmed_at: Time.now)
      @recipe1 = Recipe.create(user_id: @user.id, name: 'Burger', preparation_time: 20, cooking_time: 50, description: 'Home style american burger', public: true)
      @recipe2 = Recipe.create(user_id: @user.id, name: 'Pizza', preparation_time: 10, cooking_time: 30, description: 'Classic Italian pizza', public: false)

      visit 'users/sign_in'
      fill_in 'Email', with: 'jonasnw@gmail.com'
      fill_in 'Password', with: 'jonas123'
      click_on 'Log in'
    end

    it 'displays the information about the recipe' do
      visit '/recipes'
      expect(page).to have_content 'Burger'
      expect(page).to have_content 'Pizza'
      expect(page).to have_content 'Home style american burger'
      expect(page).to have_content 'Classic Italian pizza'
    end

    it 'shows buttons to add new recipe' do
      visit '/recipes'
      expect(page).to have_content('Add New Recipe')
    end

    it 'should take you to add new recipe form when clicking on the add new recipe button' do
      visit '/recipes'
      click_on 'Add New Recipe'
      expect(current_path).to eql '/recipes/new'
    end
  end
end
