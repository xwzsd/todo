class TodoCommentSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_many :attachments
end
