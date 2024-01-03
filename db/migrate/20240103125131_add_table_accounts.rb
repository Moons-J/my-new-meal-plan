class AddTableAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id, :height, :active_level, :exercise_level
      t.date :birthday
      t.float :weight
      t.string :sex, :phase
      t.timestamps
    end
  end
end
