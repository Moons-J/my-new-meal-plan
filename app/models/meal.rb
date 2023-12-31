class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_ingredients, dependent: :destroy
  has_many :daily_plan_meals, dependent: :destroy
  has_many :ingredients, through: :meal_ingredients
  has_one_attached :photo

  accepts_nested_attributes_for :meal_ingredients

  def calculate_nutrition(what_nutrition)
    number = 0
    self.ingredients.each do |ingredient|
      case what_nutrition
      when "calories"
        nutrition_num = ingredient.calories
      when "protein"
        nutrition_num = ingredient.protein
      when "carbs"
        nutrition_num = ingredient.carbs
      when "fats"
        nutrition_num = ingredient.fats
      when "satu-fats"
        nutrition_num = ingredient.satu_fats
      else
        return "worng arguments given to calculate_nutrition method"
      end
      amount = MealIngredient.where(meal_id: self.id, ingredient_id: ingredient.id).first.amount
      number += (nutrition_num.to_f / 100) * amount
    end
    return number.round if what_nutrition == "calories"

    return number.round(1)
  end

  include PgSearch::Model
  pg_search_scope :search_by_name_comment_ingredients, against: [ :name, :comment ],
    associated_against: {
      ingredients: [:name]
    },
    using: {
      tsearch: { prefix: true }
    }
end
