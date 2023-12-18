class GroceriesController < ApplicationController
  def index
    @groceries = Grocery.where(user: current_user)
  end

  def create
    Grocery.where(user: current_user).delete_all
    plans = Planning.where(user: current_user).select do |plan|
      plan.date >= Time.new(Time.now.year, Time.now.month, Time.now.day) && plan.date <= Time.new(Time.now.year, Time.now.month, Time.now.day + 7)
    end

    # @plans[0].daily_plan.meals[0].ingredients.count
    @meals = []
    plans.each { |plan| plan.daily_plan.meals.each { |meal| @meals << meal.meal_ingredients }}

    hash = {}
    unless @meals.empty?
      @meals.flatten.each do |meal_ingredient|
        if hash.key?(meal_ingredient.ingredient.id)
          hash[meal_ingredient.ingredient.id] = hash[meal_ingredient.ingredient.id] += meal_ingredient.amount
        else
          hash[meal_ingredient.ingredient.id] = meal_ingredient.amount
        end
      end
      @meals.flatten.uniq.each do |ingredient|
        Grocery.create!(
          ingredient: ingredient.ingredient,
          quantity: hash[ingredient.ingredient.id],
          user: current_user
        )
      end
    end
    redirect_to groceries_path
  end

  def destroy
    @grocery = Grocery.find(params[:id])
    @grocery.destroy
    redirect_to groceries_path
  end
end
