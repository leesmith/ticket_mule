class CreateAlerts < ActiveRecord::Migration
  def self.up
    create_table :alerts do |t|
      t.references :user, :null => false
      t.references :ticket, :null => false
      t.timestamps
    end

    add_index :alerts, :ticket_id
    add_index :alerts, :user_id
    add_index :alerts, [:ticket_id, :user_id], :unique => true
  end

  def self.down
    drop_table :alerts
  end
end
