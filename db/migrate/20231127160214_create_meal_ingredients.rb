class CreateMealIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_ingredients do |t|
      t.integer :amount
      t.references :meal, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
