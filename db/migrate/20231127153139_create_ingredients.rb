class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :calories
      t.float :fats
      t.float :satu_fats
      t.float :carbs
      t.float :protein
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
