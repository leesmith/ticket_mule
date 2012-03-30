class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :mobile_phone
      t.string :work_phone
      t.string :affiliation
      t.text :notes
      t.timestamps
    end
  end
end
