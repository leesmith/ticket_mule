class CreatePriorities < ActiveRecord::Migration
  def self.up
    create_table :priorities do |t|
      t.string :name, :null => false
      t.datetime :disabled_at
    end
  end

  def self.down
    drop_table :priorities
  end
end
