class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_ingredients
  has_many :daily_plan_meals
  has_many :ingredients, through: :meal_ingredients
end
