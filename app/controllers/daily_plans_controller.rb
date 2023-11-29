class DailyPlansController < ApplicationController
  def index
    @daily_plans = DailyPlan.all
  end
end
