class ChangeFormatInPlannings < ActiveRecord::Migration[7.1]
  def change
    change_column :plannings, :start_time, :date
    change_column :plannings, :end_time, :date
  end
end
