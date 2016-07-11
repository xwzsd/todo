class CreateTodoAttachments < ActiveRecord::Migration
  def change
    create_table :todo_attachments do |t|
      t.string :file
      t.references :todo_comment, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
