class IngredientsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :index

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

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :calories, :fats, :satu_fats, :carbs, :protein)
  end
end
