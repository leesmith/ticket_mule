class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.datetime :disabled_at
      t.timestamps
    end
    add_index :groups, :name, unique: true
  end
end
