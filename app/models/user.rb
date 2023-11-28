class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :ingredients
  has_many :meals
  has_many :daily_plans
  has_many :plannings

  validates :first_name, :last_name, :user_name, :birthday, :height, :exercise_level, :weight, presence: true

  validate :date_not_in_future

  def date_not_in_future
    errors.add(:birthday, "can't be in the future") if birthday.present? && birthday > Date.today
  end
end
