class CreateGroceries < ActiveRecord::Migration[7.1]
  def change
    create_table :groceries do |t|
      t.string :ingredient
      t.integer :quantity

      t.timestamps
    end
  end
end
