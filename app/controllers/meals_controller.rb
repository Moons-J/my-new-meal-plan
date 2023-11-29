class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def new
    @meal = Meal.new
  end

  # def create
  #   @meal = Meal.new
  # end

  # private

  # def meal_params
  #   params.require(:meal).permit()
  # end
end
