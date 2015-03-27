class AddFeaturedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :featured, :booleans
  end
end
