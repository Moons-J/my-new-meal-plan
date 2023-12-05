class PlanningsController < ApplicationController
  def new
    @daily_plans = DailyPlan.all
    @planning = Planning.new
  end

  def create
  end
end
