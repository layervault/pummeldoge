class AddFieldsToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :organization_permalink, :string
    add_column :movies, :project_name, :string
    add_column :movies, :folder_path, :string
    add_column :movies, :file_name, :string
  end
end
