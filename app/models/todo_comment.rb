class TodoComment < ActiveRecord::Base
	belongs_to :todo_task
	has_many :todo_attachments, dependent: :destroy

	validates :todo_task, :body, presence: true
end
