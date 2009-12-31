class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :comment, :null => false
      t.references :ticket, :null => false
      t.references :user, :null => false
      t.timestamps
    end

    add_index :comments, :ticket_id
    add_index :comments, :user_id
    #execute "alter table comments add constraint fk_ticket foreign key (ticket_id) references tickets(id)"
  end

  def self.down
    drop_table :comments
  end
end
