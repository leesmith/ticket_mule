class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :details
      t.references :status, null: false
      t.references :group, null: false
      t.references :priority, null: false
      t.references :contact
      t.integer :creator_id, null: false
      t.integer :owner_id
      t.timestamps
    end
    add_index :tickets, :status_id
    add_index :tickets, :group_id
    add_index :tickets, :priority_id
    add_index :tickets, :creator_id
    add_index :tickets, :owner_id
    add_index :tickets, :contact_id
  end
end
