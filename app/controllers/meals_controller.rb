class MealsController < ApplicationController
  def index
    user_meals = Meal.where(user: current_user)
    @query = params[:query]
    @meals = user_meals
    if @query.present?
      @meals = user_meals.search_by_name_comment_ingredients(params[:query])
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "meals/meals_list", formats: [:html] }
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to meals_path
  end
end
