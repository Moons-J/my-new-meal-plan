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

  def new
    @meal = Meal.new
    @meal.meal_ingredients.new
  end

  def create
    @meal = Meal.new(meal_ingredients_params)
    @meal.user = current_user
    if @meal.save
      redirect_to meals_path
    else
      render :new, status: unprocessable_entity
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to meals_path
  end

  # private

  def meal_ingredients_params
    params.require(:meal).permit(:name, :photo, meal_ingredients_attributes: [:amount, :ingredient_id])
  end


end
