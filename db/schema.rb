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

ActiveRecord::Schema.define(:version => 20121121055506) do

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "yardsale_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "addresses", ["user_id"], :name => "index_addresses_on_user_id"
  add_index "addresses", ["yardsale_id"], :name => "index_addresses_on_yardsale_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "categorisings", :force => true do |t|
    t.integer  "yardsale_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categorisings", ["category_id"], :name => "index_categorisings_on_category_id"
  add_index "categorisings", ["yardsale_id", "category_id"], :name => "index_categorisings_on_yardsale_id_and_category_id", :unique => true
  add_index "categorisings", ["yardsale_id"], :name => "index_categorisings_on_yardsale_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "yardsale_id"
    t.string   "comment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "comments", ["user_id", "yardsale_id"], :name => "index_comments_on_user_id_and_yardsale_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  add_index "comments", ["yardsale_id"], :name => "index_comments_on_yardsale_id"

  create_table "images", :force => true do |t|
    t.integer  "yardsale_id"
    t.string   "image"
    t.string   "remote_image_url"
    t.string   "note"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "images", ["yardsale_id"], :name => "index_images_on_yardsale_id"

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "yardsale_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["user_id", "yardsale_id"], :name => "index_relationships_on_user_id_and_yardsale_id", :unique => true
  add_index "relationships", ["user_id"], :name => "index_relationships_on_user_id"
  add_index "relationships", ["yardsale_id"], :name => "index_relationships_on_yardsale_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "yardsales", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.date     "date"
    t.time     "begin_time"
    t.time     "end_time"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "yardsales", ["user_id", "created_at"], :name => "index_yardsales_on_user_id_and_created_at"

end
