class Project < ActiveRecord::Base
  validates :title, :user_id, presence: true
  belongs_to :user

  has_many :photos, :dependent => :destroy
end
