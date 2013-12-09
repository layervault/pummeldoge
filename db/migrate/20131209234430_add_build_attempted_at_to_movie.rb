class AddBuildAttemptedAtToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :build_attempted_at, :datetime
  end
end
