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
# validation for exercise_level it should be between 1..5
  validates :exercise_level, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
# # validation for height it should be between 100..250
#   validates :height, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than_or_equal_to: 250 }
# # validation for weight it should be between 30..250
#   validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 30, less_than_or_equal_to: 250 }
# # validation for birthday it should be in the past
  validate :date_not_in_future

  after_create :copy_base_ingredients

  private

  def date_not_in_future
    errors.add(:birthday, "can't be in the future") if birthday.present? && birthday > Date.today
  end

  def copy_base_ingredients
    BaseIngredient.all.each do |ingredient|
      Ingredient.create(
      name: ingredient.name,
      calories: ingredient.calories,
      fats: ingredient.fats,
      satu_fats: ingredient.satu_fats,
      carbs: ingredient.carbs,
      protein: ingredient.protein,
      user_id: self.id
      )
    end
  end
end
