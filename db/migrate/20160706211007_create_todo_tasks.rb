class CreateTodoTasks < ActiveRecord::Migration
  def change
    create_table :todo_tasks do |t|
      t.string :content
      t.references :todo_list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
