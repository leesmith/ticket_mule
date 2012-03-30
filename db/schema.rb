# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120212032040) do

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name",    :null => false
    t.string   "email",        :null => false
    t.string   "mobile_phone"
    t.string   "work_phone"
    t.string   "affiliation"
    t.text     "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "disabled_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true

  create_table "priorities", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "disabled_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "priorities", ["name"], :name => "index_priorities_on_name", :unique => true

  create_table "statuses", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "disabled_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "statuses", ["name"], :name => "index_statuses_on_name", :unique => true

  create_table "tickets", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "details"
    t.integer  "status_id",   :null => false
    t.integer  "group_id",    :null => false
    t.integer  "priority_id", :null => false
    t.integer  "contact_id"
    t.integer  "creator_id",  :null => false
    t.integer  "owner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tickets", ["contact_id"], :name => "index_tickets_on_contact_id"
  add_index "tickets", ["creator_id"], :name => "index_tickets_on_creator_id"
  add_index "tickets", ["group_id"], :name => "index_tickets_on_group_id"
  add_index "tickets", ["owner_id"], :name => "index_tickets_on_owner_id"
  add_index "tickets", ["priority_id"], :name => "index_tickets_on_priority_id"
  add_index "tickets", ["status_id"], :name => "index_tickets_on_status_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
