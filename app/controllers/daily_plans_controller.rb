class DailyPlansController < ApplicationController
  def index
    @user = current_user
    @daily_plans = @user.daily_plans
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

  private

  def daily_plan_params
    params.require(:daily_plan).permit(:name, :photo, daily_plan_meals_attributes: %i[meal_id meal_type])
  end
end
