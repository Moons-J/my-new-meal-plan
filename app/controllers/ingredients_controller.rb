class IngredientsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :index
  before_action :set_ingredient, only: [:edit, :update, :destroy]

  def index
    user_ingredients = Ingredient.where(user: current_user)
    @query = params[:query]
    @ingredients = user_ingredients
    if @query.present?
      @ingredients = user_ingredients.search_by_name(@query)
    end
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user = current_user
    if @ingredient.save
      redirect_to ingredients_path # notice: 'Ingredient successfully added.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredients_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to ingredients_path
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :calories, :fats, :satu_fats, :carbs, :protein)
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end
