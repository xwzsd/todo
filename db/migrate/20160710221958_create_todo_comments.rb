class CreateTodoComments < ActiveRecord::Migration
  def change
    create_table :todo_comments do |t|
      t.references :todo_task, index: true, foreign_key: true
	  t.text :body

      t.timestamps null: false
    end
  end
end
