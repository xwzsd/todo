module Api
  module V1
	class TodoAttachmentsController < ApplicationController
	  load_and_authorize_resource :todo_comment
	  load_and_authorize_resource :todo_attachment, through: :todo_comment, shallow: true

	  def create
	    respond_with :api, :v1, @todo_comment.todo_attachments.create(todo_attachment_params)
	  end

	  private

	  def todo_attachment_params
	    params.permit(:file)
	  end
	end
  end
end