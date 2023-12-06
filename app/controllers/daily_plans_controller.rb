class DailyPlansController < ApplicationController
  def index
    @user = current_user
    @daily_plans = @user.daily_plans
    @planning = Planning.new
    @plannings = Planning.where(user: current_user)
    if params[:p]
      @planning = Planning.find(params[:p]) if params[:p] != ""
    end
    respond_to do |format|
      format.html
      format.text { render partial: "planning_form", locals: { planning: @planning }, formats: [:html] }
    end
  end

  def new
    @daily_plan = DailyPlan.new
    @daily_plan.daily_plan_meals.new
    @meals = Meal.where(user: current_user)
  end

  def create
    @daily_plan = DailyPlan.new(daily_plan_params)
    @daily_plan.user = current_user

    if @daily_plan.save
      redirect_to daily_plans_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @daily_plan = DailyPlan.find(params[:id])
  end

  def destroy
    @daily_plan = DailyPlan.find(params[:id])
    if @daily_plan.destroy
      redirect_to daily_plans_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def daily_plan_params
    params.require(:daily_plan).permit(:name, :photo, daily_plan_meals_attributes: %i[meal_id meal_type])
  end
end
