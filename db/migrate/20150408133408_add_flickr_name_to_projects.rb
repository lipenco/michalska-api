class AddFlickrNameToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :flickr_name, :string
  end
end
