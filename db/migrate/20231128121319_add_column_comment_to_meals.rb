class AddColumnCommentToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :comment, :text
  end
end
