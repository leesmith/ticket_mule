class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :data_file_name, :null => false
      t.string :data_content_type, :null => false
      t.integer :data_file_size, :null => false
      t.integer :download_count, :default => 0
      t.references :ticket, :null => false
      t.references :user, :null => false
      t.timestamps
    end

    add_index :attachments, :ticket_id
    add_index :attachments, :user_id
  end

  def self.down
    drop_table :attachments
  end
end
