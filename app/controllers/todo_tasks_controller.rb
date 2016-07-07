class TodoTasksController < ApplicationController
	def create
		@todo_task = todo_list.todo_task.create(todo_task_param)
		redirect_to @todo_list
	end

	private

	def set_todo_list
		@todo_list = TodoList.finde(params[:todo_list_id])
	end

	def todo_task_param
		params[:todo_task].permit(:content)
	end
end
