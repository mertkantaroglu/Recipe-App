require 'rails_helper'

RSpec.describe Food, type: :model do
  subject do
    User.create(name: 'Mert', email: 'mrtk@gmail.com', password: 'mertjonas')
  end

  before(:each) do
    @food = Food.new(name: 'Burger', measurement_unit: 'grams', price: 10, quantity: 2, user_id: subject.id)
  end

  describe 'Testing validations' do
    it 'should be validates' do
      expect(@food).to be_valid

    end

    it 'should have a name for food' do
      expect(@food.name).to eql('Burger')
    end

    it 'should have a measurement unit for food' do
      expect(@food.measurement_unit).to eql('grams')
    end

    it 'should have a price for food' do
      expect(@food.price).to eql 10
    end

    it 'should have a quantity for food' do
      expect(@food.quantity).to be >= 0
    end

    it 'should have a user id' do
      expect(@food.user_id).to be_present
    end
  end

  describe 'Testing associations' do
    it 'food should belong to a user' do
      @food = Food.reflect_on_association(:user)
      expect(@food.macro).to eql(:belongs_to)
    end

    it 'food should have many recipe items' do
      @food = Food.reflect_on_association(:recipe_foods)
      expect(@food.macro).to eql(:has_many)
    end
  end
end
