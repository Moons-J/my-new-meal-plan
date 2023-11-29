class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @query = params[:query]
    @meals = Meal.all
  end
end
