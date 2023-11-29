class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @meals = Meal.all
  end
end
