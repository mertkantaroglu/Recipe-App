class ShoppingList < ApplicationRecord
  belongs_to :user

  has_many :shopping_list_items
  has_many :foods
end
