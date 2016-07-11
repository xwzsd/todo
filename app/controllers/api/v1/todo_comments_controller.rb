module Api
  module V1
    class TodoCommentsController < ApplicationController
	    load_and_authorize_resource :todo_task
      load_and_authorize_resource :todo_comment, through: :todo_task, shallow: true

      def index
        respond_with @todo_comments
      end

      def create
        respond_with :api, :v1, @todo_task.todo_comments.create(todo_comment_params)
      end

      def destroy
        respond_with @todo_comment.destroy
      end

      private

      def todo_comment_params
        params.permit(:body)
	  end

    end
  end
end