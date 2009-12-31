class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token, :null => false
      t.integer :login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.integer :failed_login_count
      t.string :last_login_ip
      t.string :current_login_ip
      t.string :time_zone
      t.string :email, :default => "", :null => false
      t.string :first_name
      t.string :last_name
      t.boolean :admin, :null => false, :default => false
      t.string :perishable_token, :default => "", :null => false
      t.datetime :disabled_at
      t.timestamps
    end

    add_index :users, :username
    add_index :users, :persistence_token
    add_index :users, :perishable_token
    add_index :users, :last_request_at
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
