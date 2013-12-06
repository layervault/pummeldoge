class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :layervault_id
      t.string  :email
      t.string  :first_name
      t.string  :last_name
      t.string  :is_admin
      t.string  :access_token
      t.string  :current_login_ip
      t.string  :last_login_ip
      t.string  :persistence_token, null: false, default: ""

      t.timestamp :last_login_at
      t.timestamps
    end

    add_index :users, :layervault_id, unique: true
    add_index :users, :email, unique: true
    add_index :users, :persistence_token, unique: true
  end
end
