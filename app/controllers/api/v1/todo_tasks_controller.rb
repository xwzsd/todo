module Api
  module V1
    class TodoTasksController < ApplicationController
	    load_and_authorize_resource :todo_list
      load_and_authorize_resource :todo_task, through: :todo_list, shallow: true

      def index
        respond_with @todo_tasks
      end

      def create
        respond_with :api, :v1, @todo_list.todo_tasks.create(todo_task_params)
      end

      def update
        respond_with @todo_task.update(todo_task_params)
      end

      def destroy
        respond_with @todo_task.destroy
      end

      private

      def todo_task_params
        params.permit(:content, :completed_at, :priority, :due_date)
	    end
    end
  end
end
