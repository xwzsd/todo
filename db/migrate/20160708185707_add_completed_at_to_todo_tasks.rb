class AddCompletedAtToTodoTasks < ActiveRecord::Migration
  def change
    add_column :todo_tasks, :completed_at, :datetime
  end
end
