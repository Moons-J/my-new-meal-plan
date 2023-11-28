class CreateDailyPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_plans do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
