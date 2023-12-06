class GroceriesController < ApplicationController
  def index
    @groceries = Grocery.where(user: current_user)
  end

  def create
    plans = Planning.where(user: current_user).select do |plan|
      plan.date >= Time.now.day && plan.date <= Time.new(Time.now.year, Time.now.month, Time.now.day + 7)
    end
    # @plans[0].daily_plan.meals[0].ingredients.count
    @ingredients = []
    plans.each do |plan|
      plan.daily_plan.meals.each { |meal| meal.ingredients.each { |ingredient| @ingredients << ingredient.name }}
    end

    @ingredients.each do |ingredient|
      Grocery.create!(
        ingredient: ingredient,
        quantity: @ingredients.count(ingredient),
        user: current_user
      )
    end
  end

  def destroy
    @grocery = Grocery.find(params[:id])
    @grocery.destroy
    redirect_to groceries_path
  end
end
