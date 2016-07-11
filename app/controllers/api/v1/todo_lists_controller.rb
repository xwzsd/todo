module Api
  module V1
    class TodoListsController < ApplicationController
      load_and_authorize_resource

      def index
        respond_with @todo_lists
      end

      def show
        respond_with @todo_list
      end

      def create
        respond_with :api, :v1, current_user.todo_lists.create(todo_list_params)
      end

      def update
        respond_with @todo_list.update(todo_list_params)
      end

      def destroy
        respond_with @todo_list.destroy
      end

      private

      def todo_list_params
        params.permit(:title, :priority, :todo_tasks)
      end
    end
  end
end
