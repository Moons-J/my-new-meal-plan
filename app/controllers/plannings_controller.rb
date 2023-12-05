class PlanningsController < ApplicationController
  def new
    @planning = Planning.new
    @daily_plans = DailyPlan.all
  end

  def create
    @planning = Planning.new(planning_params)
    @planning.user = current_user
    if @planning.save
      redirect_to daily_plans_path
    else
      render daily_plans_path, status: :unprocessable_entity
    end
  end

  private

  def planning_params
    params.require(:planning).permit(:daily_plan_id, :exercise, :date)
  end
end
