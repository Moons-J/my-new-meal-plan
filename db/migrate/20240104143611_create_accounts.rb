class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.integer :height, :active_level, null: false
      t.date :birthday, null: false
      t.float :weight, null: false
      t.string :sex, :phase, null: false
      t.timestamps
    end
  end
end
