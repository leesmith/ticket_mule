class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :title, :null => false
      t.text :details
      t.references :group, :null => false
      t.references :status, :null => false
      t.references :priority, :null => false
      t.references :contact, :null => false
      t.integer :created_by, :null => false
      t.integer :owned_by
      t.datetime :closed_at
      t.integer :comments_count, :default => 0 #counter cache field
      t.timestamps
    end

    add_index :tickets, :group_id
    add_index :tickets, :status_id
    add_index :tickets, :priority_id
    add_index :tickets, :contact_id
    add_index :tickets, :created_by
    add_index :tickets, :owned_by
  end

  def self.down
    drop_table :tickets
  end
end
