class DailyPlansController < ApplicationController
  def index
    @user = current_user
    @daily_plans = @user.daily_plans
  end
end
