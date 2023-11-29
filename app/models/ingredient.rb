class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :meal_ingredients, dependent: :destroy
end
