class Planning < ApplicationRecord
  belongs_to :daily_plan
  belongs_to :user

  
  validates :daily_plan_id, presence: true
  validate :unique_data_per_user

  private

  def unique_data_per_user
    if Planning.where(date: date, user_id: user_id).exists?
      errors.add(:date, "must be unique per user")
    end
  end
end
