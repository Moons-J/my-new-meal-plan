class DailyPlan < ApplicationRecord
  belongs_to :user

  has_many :plannings
  has_many :daily_plan_meals
  has_many :meals, through: :daily_plan_meals

  def start_time
    self.my_related_model.start ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
