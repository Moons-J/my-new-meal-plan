class AddStartTimeAndEndTimeToPlanning < ActiveRecord::Migration[7.1]
  def change
    add_column :plannings, :start_time, :datetime
    add_column :plannings, :end_time, :datetime
  end
end
