class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.attachment :movie_data
      t.attachment :h264
      t.attachment :gif

      t.timestamps
    end
  end
end
