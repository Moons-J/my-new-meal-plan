class AccountController < ApplicationController

  def user_calories(current_user)
    user_nutri_calculation(current_user) * real_active_level(current_user) * user_phase(current_user)
  end

  def min_user_fats(current_user)
    current_user.weight * 0.9 * 9
  end

  def max_user_satu_fats(current_user)
    user_calories(current_user) * 0.1
  end

  def max_user_carbs(current_user)
    user_calories(current_user) * 0.65
  end

  def min_user_protein(current_user)
    case current_user.phase
    when "gain"
      current_user.weight * 2 * 1.1
    else
      current_user.weight * 2
    end
  end

  private

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
