class AddActiveLevelToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :active_level, :integer, null: false, default: 1
  end
end
