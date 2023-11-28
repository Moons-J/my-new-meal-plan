class IngredientsController < ApplicationController
  def index
    @ingredients = Indredient.all
  end
end
