class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    # @ingredients = Indredient.all
  end
end
