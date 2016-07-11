class TodoAttachment < ActiveRecord::Base
	mount_uploader :file, TodoFileUploader

	belongs_to :todo_comment

	validates :file, :todo_comment, presence: true
end
