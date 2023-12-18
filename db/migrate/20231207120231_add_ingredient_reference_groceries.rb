class AddIngredientReferenceGroceries < ActiveRecord::Migration[7.1]
  def change
    remove_column :groceries, :ingredient
    add_reference :groceries, :ingredient, null: false, foreign_key: true
  end
end
