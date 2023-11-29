class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @meals = Meal.all
  end

  def calculate_nutrition
    calories = 0
    self.ingredients.each do |ingredient|
      calories += ingredient.calories
    end
    return calories
  end
end
