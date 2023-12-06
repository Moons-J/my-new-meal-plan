class Planning < ApplicationRecord
  belongs_to :daily_plan
  belongs_to :user

  validates :date, uniqueness: true, presence: true
  validates :daily_plan_id, presence: true
end
