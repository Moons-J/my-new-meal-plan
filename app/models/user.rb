class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :ingredients
  has_many :meals
  has_many :daily_plans
  has_many :plannings
  has_many :weight_histories

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

  def user_calories(current_user)
    user_nutri_calculation(current_user) * real_active_level(current_user) * user_phase(current_user)
  end

  def minimum_user_fats(current_user)
    current_user.weight * 0.9 * 9
  end

  def user_satu_fats(current_user)
    user_calories(current_user) * 0.1
  end

  def user_carbs(current_user)
    user_calories(current_user) * 0.65
  end

  def user_protein(current_user)
    case current_user.phase
    when "gain"
      current_user.weight * 2 * 1.1
    else
      current_user.weight * 2
    end
  end

  private

  def date_not_in_future
    errors.add(:birthday, "can't be in the future") if birthday.present? && birthday > Date.today
    end
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

  def user_phase(current_user)
    case current_user.phase
    when "gain"
      phase = 1.1
    when "maintain"
      phase = 1
    when "lose"
      phase = 0.9
    end
  end

  def real_active_level(current_user)
    case current_user.active_level
    when 1
      new_active_level = 1.2
    when 2
      new_active_level = 1.375
    when 3
      new_active_level = 1.55
    when 4
      new_active_level = 1.725
    when 5
      new_active_level = 1.9
  end

  def user_nutri_calculation(current_user)
    if current_user.sex == "male"
      bmr = 66.5 + (13.75 * current_user.weight) + (5.003 * current_user.height) - (6.755 * current_user.age)
    elsif current_user.sex == "female"
      bmr = 655.1 + (9.563 * current_user.weight) + (1.85 * current_user.height) - (4.676 * current_user.age)
    else
      bmr = 325 + (12 * current_user.weight) + (3.5 * current_user.height) - (6 * current_user.age)
    end
  end

end
