class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, default: ""
      t.text :description, default: ""
      t.boolean :published, default: false
      t.string :thumbnail
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
