class CreateBaseIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :base_ingredients do |t|
      t.string :name
      t.integer :calories
      t.float :fats
      t.float :satu_fats
      t.float :carbs
      t.float :protein

      t.timestamps
    end
  end
end
