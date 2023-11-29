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
