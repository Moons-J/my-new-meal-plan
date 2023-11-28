class CreatePlannings < ActiveRecord::Migration[7.1]
  def change
    create_table :plannings do |t|
      t.date :date
      t.boolean :exercise
      t.references :daily_plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
