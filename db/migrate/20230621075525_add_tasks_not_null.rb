class AddTasksNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :name, :detail, false
  end
end
