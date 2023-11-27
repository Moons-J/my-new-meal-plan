class DailyPlan < ApplicationRecord
  belongs_to :user

  has_many :plannings
  has_many :daily_plan_meals
  has_many :meals, through: :daily_plan_meals
end
