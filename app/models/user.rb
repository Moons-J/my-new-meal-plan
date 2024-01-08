class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one :account
  has_many :ingredients
  has_many :meals
  has_many :daily_plans
  has_many :plannings
  has_many :weight_histories

  validates :email, :password, presence: true
  # validation for exercise_level it should be between 1..5
  # validates :exercise_level, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  # # validation for height it should be between 100..250
  #   validates :height, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than_or_equal_to: 250 }
  # # validation for weight it should be between 30..250
  #   validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 30, less_than_or_equal_to: 250 }
  # # validation for birthday it should be in the past
  # validate :date_not_in_future

  after_create :copy_base_ingredients

  private

  def copy_base_ingredients
    BaseIngredient.all.each do |ingredient|
      create_ingredient(ingredient)
    end
  end

  def create_ingredient(base_ingredient)
    Ingredient.create(
      name: base_ingredient.name,
      calories: base_ingredient.calories,
      fats: base_ingredient.fats,
      satu_fats: base_ingredient.satu_fats,
      carbs: base_ingredient.carbs,
      protein: base_ingredient.protein,
      user_id: id
    )
  end
end
