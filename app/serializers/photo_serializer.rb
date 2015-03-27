class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :url, :horizontal, :featured
end
