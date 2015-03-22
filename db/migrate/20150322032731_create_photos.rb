class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :project, index: true, foreign_key: true
      t.string :url
      t.text :description
      t.boolean :horizontal, default: true

      t.timestamps null: false
    end
  end
end
