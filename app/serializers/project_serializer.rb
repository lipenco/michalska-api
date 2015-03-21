class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :thumbnail, :description, :published
end
