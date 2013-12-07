class AddUserToMovie < ActiveRecord::Migration
  def change
    add_reference :movies, :user, index: true
  end
end
