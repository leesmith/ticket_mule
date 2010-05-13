# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090914141258) do

  create_table "alerts", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "ticket_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["ticket_id", "user_id"], :name => "index_alerts_on_ticket_id_and_user_id", :unique => true
  add_index "alerts", ["ticket_id"], :name => "index_alerts_on_ticket_id"
  add_index "alerts", ["user_id"], :name => "index_alerts_on_user_id"

  create_table "attachments", :force => true do |t|
    t.string   "data_file_name",                   :null => false
    t.string   "data_content_type",                :null => false
    t.integer  "data_file_size",                   :null => false
    t.integer  "download_count",    :default => 0
    t.integer  "ticket_id",                        :null => false
    t.integer  "user_id",                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["ticket_id"], :name => "index_attachments_on_ticket_id"
  add_index "attachments", ["user_id"], :name => "index_attachments_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "comment",    :null => false
    t.integer  "ticket_id",  :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ticket_id"], :name => "index_comments_on_ticket_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name",    :null => false
    t.string   "email",        :null => false
    t.string   "mobile_phone"
    t.string   "office_phone"
    t.string   "affiliation"
    t.text     "notes"
    t.datetime "disabled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "disabled_at"
  end

  create_table "priorities", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "disabled_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "disabled_at"
  end

  create_table "tickets", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "details"
    t.integer  "group_id",                      :null => false
    t.integer  "status_id",                     :null => false
    t.integer  "priority_id",                   :null => false
    t.integer  "contact_id",                    :null => false
    t.integer  "created_by",                    :null => false
    t.integer  "owned_by"
    t.datetime "closed_at"
    t.integer  "comments_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["contact_id"], :name => "index_tickets_on_contact_id"
  add_index "tickets", ["created_by"], :name => "index_tickets_on_created_by"
  add_index "tickets", ["group_id"], :name => "index_tickets_on_group_id"
  add_index "tickets", ["owned_by"], :name => "index_tickets_on_owned_by"
  add_index "tickets", ["priority_id"], :name => "index_tickets_on_priority_id"
  add_index "tickets", ["status_id"], :name => "index_tickets_on_status_id"

  create_table "users", :force => true do |t|
    t.string   "username",                              :null => false
    t.string   "crypted_password",                      :null => false
    t.string   "password_salt",                         :null => false
    t.string   "persistence_token",                     :null => false
    t.integer  "login_count",        :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.integer  "failed_login_count"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "time_zone"
    t.string   "email",              :default => "",    :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",              :default => false, :null => false
    t.string   "perishable_token",   :default => "",    :null => false
    t.datetime "disabled_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["username"], :name => "index_users_on_username"

end
