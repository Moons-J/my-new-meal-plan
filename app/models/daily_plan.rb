class DailyPlan < ApplicationRecord
  belongs_to :user

  has_many :plannings, dependent: :destroy
  has_many :daily_plan_meals, dependent: :destroy
  has_many :meals, through: :daily_plan_meals
  has_one_attached :photo

  accepts_nested_attributes_for :daily_plan_meals

  def start_time
    self.my_related_model.start # Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end

  def calculate_nutrition(what_nutrition)
    number = 0
    self.meals.each do |meal|
      case what_nutrition
      when "calories"
        nutrition_num = meal.calculate_nutrition("calories")
      when "protein"
        nutrition_num = meal.calculate_nutrition("protein")
      when "carbs"
        nutrition_num = meal.calculate_nutrition("carbs")
      when "fats"
        nutrition_num = meal.calculate_nutrition("fats")
      when "satu-fats"
        nutrition_num = meal.calculate_nutrition("satu-fats")
      else
        return "worng arguments given to calculate_nutrition method"
      end
      number += nutrition_num.to_f
    end
    return number.round if what_nutrition == "calories"

    return number.round(1)
  end

  validates :name, presence: true
end
