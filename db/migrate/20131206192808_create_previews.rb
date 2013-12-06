class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.references :movie, index: true
      t.string :url
      t.attachment :preview_data
      t.attachment :movie_data
      t.attachment :gif_data

      t.timestamps
    end
  end
end
