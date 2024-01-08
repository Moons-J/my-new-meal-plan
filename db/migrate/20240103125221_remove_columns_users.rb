class RemoveColumnsUsers < ActiveRecord::Migration[7.1]
  def change
    remove_columns :users, :height, :active_level, :exercise_level, :birthday, :weight, :sex, :phase
  end
end
