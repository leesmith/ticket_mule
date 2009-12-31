class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :name, :null => false
      t.datetime :disabled_at
    end
  end

  def self.down
    drop_table :statuses
  end
end
