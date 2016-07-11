class TodoAttachmentSerializer < ActiveModel::Serializer
  attributes :id, :file, :file_identifier
end
