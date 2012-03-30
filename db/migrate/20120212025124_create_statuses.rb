class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name, null: false
      t.datetime :disabled_at
      t.timestamps
    end
    add_index :statuses, :name, unique: true
  end
end
