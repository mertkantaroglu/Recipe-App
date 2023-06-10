class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :foods, foreign_key: 'user_id'
  has_many :recipes, foreign_key: 'user_id'

  def owner?(recipe_id)
    recipes.exists?(id: recipe_id)
  end
end
