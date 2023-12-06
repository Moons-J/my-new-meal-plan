class GroceriesController < ApplicationController
  def index
    plans = Planning.all.select do |plan|
      plan.date >= Time.now.day && plan.date <= Time.new(Time.now.year, Time.now.month, Time.now.day + 7)
    end
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
