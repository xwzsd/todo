class TodoListSerializer < ActiveModel::Serializer
  attributes :id, :title, :priority
  has_many :todo_tasks
end
