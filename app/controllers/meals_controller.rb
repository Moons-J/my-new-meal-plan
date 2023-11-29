class MealsController < ApplicationController
  def index
    user_meals = Meal.where(user: current_user)
    @query = params[:query]
    @meals = user_meals
    if @query
      @meals = user_meals.search_by_name_comment_ingredients(params[:query])
    end
  end
end
