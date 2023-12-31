class WeightHistory < ApplicationRecord
  belongs_to :user
  validates :weight, presence: true
  validate :once_per_day

  private

  def once_per_day
    time = Time.now.beginning_of_day
    time_range = time..Time.now
    if WeightHistory.where(user: self.user, created_at: time_range).exists?
      errors.add(:weight, "You can only add one weight per day")
    end
  end
end
