class Account < ApplicationRecord
  belongs_to :user

  def percentage_calculation(total, part)
    (part.to_f / total.to_f) * 100
  end

  def current_weight
    self.user.weight_histories.order(:created_at).pluck(:weight).last
  end

  def user_calories
    total = self.user_nutri_calculation * self.real_active_level * self.user_phase
    total.to_i
  end

  def min_user_fats
    value_weight = self.current_weight.nil? ? 60 : self.current_weight
    total = value_weight * 0.9 * 9
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
    value_weight = self.current_weight.nil? ? 60 : self.current_weight
    case self.phase
    when "gain"
      total = value_weight * 2 * 1.1
    else
      total = value_weight * 2
    end
    total.round(1)
  end

  private

  def date_not_in_future
    errors.add(:birthday, "can't be in the future") if birthday.present? && birthday > Date.today
  end

  def age_year
    Date.today.year - self.birthday.year
  end

  def user_phase
    value_phase = self.phase.empty? ? "maintain" : self.phase
    case value_phase
    when "gain"
      phase = 1.1
    when "maintain"
      phase = 1.0
    when "lose"
      phase = 0.9
    end
  end

  def real_active_level
    value_active_level = self.active_level.nil? ? 1 : self.active_level
    case value_active_level
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
    value_weight = self.current_weight.nil? ? 60 : self.current_weight
    value_height = self.height.nil? ? 1.60 : self.height
    value_year = self.age_year.nil? ? (Date.today.year - 25) : self.age_year
    if self.sex == "male"
      bmr = 66.5 + (13.75 * value_weight) + (5.003 * value_height) - (6.755 * self.age_year)
    elsif self.sex == "female"
      bmr = 655.1 + (9.563 * value_weight) + (1.85 * value_height) - (4.676 * self.age_year)
    else
      bmr = 325 + (12 * value_weight) + (3.5 * value_height) - (6 * self.age_year)
    end
  end
end