class RemoveColumnsFromPlanning < ActiveRecord::Migration[7.1]
  def change
    remove_column :plannings, :start_time, :date
    remove_column :plannings, :end_time, :date
  end
end
