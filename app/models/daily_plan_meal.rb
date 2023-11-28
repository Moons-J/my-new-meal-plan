class DailyPlanMeal < ApplicationRecord
  belongs_to :meal
  belongs_to :daily_plan
end
