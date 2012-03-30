class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.string :name, null: false
      t.datetime :disabled_at
      t.timestamps
    end
    add_index :priorities, :name, unique: true
  end
end
