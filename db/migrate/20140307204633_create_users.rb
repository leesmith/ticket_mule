class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.boolean :enabled
      t.string :password_digest
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.timestamps
    end

    add_index :users, :auth_token
    add_index :users, :email, unique: true
  end
end
