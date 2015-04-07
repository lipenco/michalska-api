class AddPhotosetIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :photoset_id, :string
  end
end
