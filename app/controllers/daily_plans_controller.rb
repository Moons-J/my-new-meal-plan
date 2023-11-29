class DailyPlansController < ApplicationController
  def index
    @user = current_user
    @daily_plans = DailyPlan.all
  end
end
