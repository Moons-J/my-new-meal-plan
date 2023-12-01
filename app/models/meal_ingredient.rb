class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient
  after_create :remove_empty

  private

  def remove_empty
    destroy if amount.nil?
  end
end
