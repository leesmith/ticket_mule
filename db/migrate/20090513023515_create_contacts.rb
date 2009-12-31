class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :mobile_phone
      t.string :office_phone
      t.string :affiliation
      t.text :notes
      t.datetime :disabled_at
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
