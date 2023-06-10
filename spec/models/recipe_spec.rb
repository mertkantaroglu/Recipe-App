require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject do
    User.create(name: 'Jonas', email: 'jonasnw@gmail.com', password: 'jonas123')
  end

  before(:each) do
    @recipe = Recipe.new(user_id: subject.id, name: 'Burger', preparation_time: 20, cooking_time: 50, description: 'Home style american burger', public: true)
  end

  describe 'Testing validations' do
    it 'validation should be successful' do
      expect(@recipe).to be_valid
    end

    it 'should have a user id' do
      expect(@recipe.user_id).to be_present
    end

    it 'should have a name for recipe' do
      expect(@recipe.name).to eql 'Burger'
    end

    it 'should have a preparation time' do
      expect(@recipe.preparation_time.to_i).to be >= 0
    end

    it 'should have a cooking time' do
      expect(@recipe.cooking_time.to_i).to be >= 0
    end

    it 'should have a description' do
      expect(@recipe.description).to be_present
    end

    it 'should have a public check' do
      expect(@recipe.public).to eql true
    end
  end

  describe 'Testing Associations' do
    it 'recipe should belong to a user' do
      @recipe = Recipe.reflect_on_association(:user)
      expect(@recipe.macro).to eql(:belongs_to)
    end

    it 'recipe should have many recipe foods' do
      @recipe = Recipe.reflect_on_association(:recipe_foods)
      expect(@recipe.macro).to eql(:has_many)
    end
  end
end
