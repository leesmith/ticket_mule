class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name, :null => false
      t.datetime :disabled_at
    end
  end

  def self.down
    drop_table :groups
  end
end
