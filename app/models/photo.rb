class Photo < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true
  validates :url, presence: true
  
end
