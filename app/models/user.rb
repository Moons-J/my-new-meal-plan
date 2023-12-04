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

  def percentage_calculation(total, part)
    (part.to_f / total.to_f) *100
  end

  def user_calories
    total = self.user_nutri_calculation * self.real_active_level * self.user_phase
    total.to_i
  end

  def min_user_fats
    total = self.weight * 0.9 * 9
    total.round(1)
  end

  def max_user_satu_fats
    total = user_calories * 0.1
    total.round(1)
  end

  def max_user_carbs
    total = user_calories * 0.65
    total.round(1)
  end

  def min_user_protein
    case self.phase
    when "gain"
      total = self.weight * 2 * 1.1
    else
      total = self.weight * 2
    end
    total.round(1)
  end

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

    def age_year
      Date.today.year - self.birthday.year
    end

    def user_phase
      case self.phase
      when "gain"
        phase = 1.1
      when "maintain"
        phase = 1.0
      when "lose"
        phase = 0.9
      end
    end

    def real_active_level
      case self.active_level
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
    end

  def user_nutri_calculation
    if self.sex == "male"
      bmr = 66.5 + (13.75 * self.weight) + (5.003 * self.height) - (6.755 * self.age_year)
    elsif self.sex == "female"
      bmr = 655.1 + (9.563 * self.weight) + (1.85 * self.height) - (4.676 * self.age_year)
    else
      bmr = 325 + (12 * self.weight) + (3.5 * self.height) - (6 * self.age_year)
    end
  end
end
