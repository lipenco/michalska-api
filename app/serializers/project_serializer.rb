class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :thumbnail, :description, :published, :project_date
  has_many :photos
end
