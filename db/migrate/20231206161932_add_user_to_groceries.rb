class AddUserToGroceries < ActiveRecord::Migration[7.1]
  def change
    add_reference :groceries, :user, null: false, foreign_key: true
  end
end
