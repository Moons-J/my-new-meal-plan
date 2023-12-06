class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @plannings = Planning.where(user: current_user)
    @updated_planning = []
    @daily_meals = { breakfast: "", lunch: "", dinner: "" }
    if @plannings.length.positive?
      @arranged_plannings = @plannings.sort_by(&:date)
      @updated_planning = @arranged_plannings.select do |meal|
        meal.date >= Time.now.day
      end
    end
    @weight_history = WeightHistory.new
  end
end
