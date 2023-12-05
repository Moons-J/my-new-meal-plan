class GroceriesController < ApplicationController
  def index
    plans = Planning.all.select { |plan| plan.start_time >= Time.new(2023, 12, 4) } # Time.new(2023, 12, 4)
    # @plans[0].daily_plan.meals[0].ingredients.count
    ingredients = []
    plans.each do |plan|
      plan.daily_plan.meals.each { |meal| meal.ingredients.each { |ingredient| ingredients << ingredient.name }}
    end
    @grocerie_list = {}
    ingredients.each { |ingredient| @grocerie_list[ingredient] = ingredients.count(ingredient) }
    @grocerie_list
  end
end
