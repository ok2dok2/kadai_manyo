class AddIndexTasksName < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, [:name, :status]
  end
end
