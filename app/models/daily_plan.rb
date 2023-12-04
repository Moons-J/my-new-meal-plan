class DailyPlan < ApplicationRecord
  belongs_to :user

  has_many :plannings, dependent: :destroy
  has_many :daily_plan_meals, dependent: :destroy
  has_many :meals, through: :daily_plan_meals

  def start_time
    self.my_related_model.start ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
