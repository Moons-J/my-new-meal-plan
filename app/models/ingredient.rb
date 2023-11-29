class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :meal_ingredients, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
