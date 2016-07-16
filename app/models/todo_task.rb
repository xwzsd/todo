class TodoTask < ActiveRecord::Base
  validates :todo_list, :content, presence: true

  belongs_to :todo_list
  has_many :todo_comments, dependent: :destroy

  default_scope { order(completed_at: :asc, priority: :asc) }
end
