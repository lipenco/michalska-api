class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :thumbnail, :description, :published
  has_many :photos
end
