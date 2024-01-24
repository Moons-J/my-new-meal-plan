class Account < ApplicationRecord
  belongs_to :user

  def percentage_calculation(total, part)
    (part.to_f / total.to_f) * 100
  end

  def current_weight
    self.user.weight_histories.last.weight
  end

  def user_calories
    ((user_nutri_calculation * real_active_level) * user_phase).to_i
  end

  def min_user_fats
    (value_weight * 0.9).round(1)
  end

  def max_user_satu_fats
    (user_calories * 0.1 / 9).round(1)
  end

  def max_user_carbs
    (user_calories * 0.65 / 4).round(1)
  end

  def min_user_protein
    case phase
    when "gain"
      total = value_weight * 2 * 1.1
    else
      total = value_weight * 2
    end
    total.round(1)
  end

  private

  def value_weight
    current_weight.nil? ? 60 : current_weight
  end

  def date_not_in_future
    errors.add(:birthday, "can't be in the future") if birthday.present? && birthday > Date.today
  end

  def age_year
    Date.today.year - birthday.year
  end

  def user_phase
    value_phase = phase.empty? ? "maintain" : phase
    case value_phase
    when "gain"
      1.1
    when "maintain"
      1.0
    when "lose"
      0.9
    end
  end

  def real_active_level
    value_active_level = active_level.nil? ? 1 : active_level
    case value_active_level
    when 1
      1.2
    when 2
      1.375
    when 3
      1.55
    when 4
      1.725
    when 5
      1.9
    end
  end

  def user_nutri_calculation
    value_height = height.nil? ? 1.60 : height
    value_year = age_year.nil? ? (Date.today.year - 25) : age_year
    if sex == "male"
      66.5 + (13.75 * value_weight) + (5.003 * value_height) - (6.755 * age_year)
    elsif sex == "female"
      655.1 + (9.563 * value_weight) + (1.85 * value_height) - (4.676 * age_year)
    else
      325 + (12 * value_weight) + (3.5 * value_height) - (6 * age_year)
    end
  end
end
