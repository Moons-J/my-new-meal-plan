class IngredientsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :index

  def index
    user_ingredients = Ingredient.where(user: current_user)
    @ingredients = user_ingredients
    if params[:query].present?
      @ingredients = user_ingredients.search_by_name(params[:query])
    end
  end
end
