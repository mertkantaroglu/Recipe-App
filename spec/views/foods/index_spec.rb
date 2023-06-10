require 'rails_helper'

RSpec.describe 'foods/index', type: :feature do
  describe 'after log in' do
    before(:each) do
      @user1 = User.create(name: 'Mert', email: 'mk@gmail.com', password: 'mert1234', confirmed_at: Time.now)
      @food1 = Food.create(name: 'Burger', measurement_unit: 'grams', price: 10, quantity: 2, user_id: @user1.id)
      @food2 = Food.create(name: 'Pizza', measurement_unit: 'slices', price: 20, quantity: 5, user_id: @user1.id)

      visit 'users/sign_in'
      fill_in 'Email', with: 'mk@gmail.com'
      fill_in 'Password', with: 'mert1234'
      click_on 'Log in'
    end

    it 'displays Foods list in navbar' do
      visit 'foods'
      expect(page).to have_content 'Food'
    end

    it 'displays a list of the foods' do
      visit 'foods'
      expect(page).to have_content 'Burger'
      expect(page).to have_content 'Pizza'
    end

    it 'has a button to add new food' do
      visit 'foods'
      expect(page).to have_content 'Add New Food'
    end

    it 'should take you to add food form when clicking on the button' do
      visit 'foods'
      click_on 'Add New Food'
      expect(current_path).to eql new_user_food_path(@user1)
    end
  end
end
