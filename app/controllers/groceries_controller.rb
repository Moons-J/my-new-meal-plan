class GroceriesController < ApplicationController
  def index
    @groceries = Grocery.where(user: current_user)
  end

  def create
    Grocery.where(user: current_user).delete_all
    plans = Planning.where(user: current_user).select do |plan|
      plan.date >= Time.now && plan.date <= Time.new(Time.now.year, Time.now.month, Time.now.day + 7)
    end
    # @plans[0].daily_plan.meals[0].ingredients.count
    @meals = []
    plans.each do |plan|
      plan.daily_plan.meals.each do |meal|
        @meals << meal.meal_ingredients
        # meal.ingredients.each do |ingredient|
        #   @ingredients << ingredient.name
        # end
      end
    end

    # @ingredients.each do |ingredient|
    #   Grocery.create!(
    #     ingredient: ingredient,
    #     quantity: @ingredients.count(ingredient),
    #     user: current_user
    #   )
    # end
    hash = {}
    unless @meals.empty?
      @meals.flatten.each do |meal_ingredient|
        Grocery.create!(
          ingredient: meal_ingredient.ingredient,
          quantity: 0,
          user: current_user
        )

        if hash.key?(meal_ingredient.ingredient.id)
          hash[meal_ingredient.ingredient.id] = hash[meal_ingredient.ingredient.id] += meal_ingredient.amount
        else
          hash[meal_ingredient.ingredient.id] = meal_ingredient.amount
        end
      end
    end

    Grocery.all.each do |g|
      g.update(quantity: hash[g.ingredient.id])
    end
    redirect_to groceries_path
  end

  def destroy
    @grocery = Grocery.find(params[:id])
    @grocery.destroy
    redirect_to groceries_path
  end
end
