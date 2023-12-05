class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient
  has_one :user, through: :meal

  validate :ingredient_belongs_to_user

  private

  def ingredient_belongs_to_user
    unless self.user == self.ingredient.user
      errors.add(:ingredient, "must belong to the same user as the meal")
    end
  end
end
