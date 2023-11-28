class CreateDailyPlanMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_plan_meals do |t|
      t.string :meal_type
      t.references :meal, null: false, foreign_key: true
      t.references :daily_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
