class PlanningsController < ApplicationController
  def create
    @planning = Planning.new(planning_params)
    @planning.user = current_user
    if @planning.save
      redirect_to daily_plans_path, notice: "Plan added"
    else
      redirect_to daily_plans_path, notice: "The plan could not be added: #{@planning.errors.full_messages.join(", ")}"
    end
  end

  def edit
    @planning = Planning.find(params[:id])
  end

  def update
    @planning = Planning.find(params[:id])
    @planning.user = current_user
    if @planning.update
      redirect_to daily_plans_path, notice: "Plan updated"
    else
      redirect_to daily_plans_path, notice: "The plan could not be added: #{@planning.errors.full_messages.join(", ")}"
    end
  end

  private

  def planning_params
    params.require(:planning).permit(:daily_plan_id, :exercise, :date)
  end
end
