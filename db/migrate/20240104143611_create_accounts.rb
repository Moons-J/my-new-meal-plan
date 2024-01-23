class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.float :height, :active_level, null: true
      t.date :birthday, null: true
      t.float :weight, null: true
      t.string :sex, :phase, null: true
      t.timestamps
    end
  end
end
