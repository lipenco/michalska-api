class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :thumbnail, :description, :published, :project_date, :photoset_id
  has_many :photos
end
