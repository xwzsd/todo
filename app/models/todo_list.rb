class TodoList < ActiveRecord::Base
	has_many :todo_tasks, dependent: :destroy
end
