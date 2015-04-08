class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :thumbnail, :description, :published, :project_date, :flickr_name
  has_many :photos
end
