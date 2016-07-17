class TodoCommentSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_many :todo_attachments
end
