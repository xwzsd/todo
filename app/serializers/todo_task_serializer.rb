class TodoTaskSerializer < ActiveModel::Serializer
  attributes :id, :content, :completed_at, :priority, :due_date
  has_many :todo_comments
end
