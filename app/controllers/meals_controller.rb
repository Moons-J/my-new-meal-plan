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
  end

  def create
    @meal = Meal.new(meal_ingredients_params)
    @meal.user = current_user
    if @meal.save
      redirect_to meals_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.meal_ingredients.destroy_all
    @meal.update(meal_ingredients_params)

    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to meals_path
  end

  # private

  def meal_ingredients_params
    params.require(:meal).permit(:name, :photo, :comment, meal_ingredients_attributes: [:amount, :ingredient_id])
  end


end
