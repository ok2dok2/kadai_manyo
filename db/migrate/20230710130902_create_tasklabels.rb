class CreateTasklabels < ActiveRecord::Migration[6.1]
  def change
    create_table :tasklabels do |t|
      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
