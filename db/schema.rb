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

ActiveRecord::Schema.define(:version => 20140719133909) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "full_name"
    t.string   "room"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "book_groups", :force => true do |t|
    t.string   "title",              :null => false
    t.string   "author"
    t.string   "publisher"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "category_id"
  end

  add_index "book_groups", ["author"], :name => "index_book_groups_on_author"
  add_index "book_groups", ["category_id"], :name => "index_book_groups_on_category_id"
  add_index "book_groups", ["title"], :name => "index_book_groups_on_title"

  create_table "books", :force => true do |t|
    t.integer  "edition"
    t.string   "isbn"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "user_id"
    t.integer  "college_id"
    t.integer  "price"
    t.integer  "book_group_id"
    t.boolean  "sold",          :default => false
    t.boolean  "reserved",      :default => false
    t.integer  "admin_user_id"
    t.integer  "buyer_id"
    t.boolean  "by_guest",      :default => false
  end

  add_index "books", ["admin_user_id"], :name => "index_books_on_admin_user_id"
  add_index "books", ["book_group_id"], :name => "index_books_on_book_group_id"
  add_index "books", ["buyer_id"], :name => "index_books_on_buyer_id"
  add_index "books", ["college_id"], :name => "index_books_on_college_id"
  add_index "books", ["user_id"], :name => "index_books_on_user_id"

  create_table "categories", :force => true do |t|
    t.string "name"
    t.string "image_name"
  end

  create_table "city_vendors", :force => true do |t|
    t.string   "vendor_name",   :default => "", :null => false
    t.string   "mobile",        :default => "", :null => false
    t.string   "email",         :default => "", :null => false
    t.string   "city",          :default => "", :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "password_hash", :default => "", :null => false
    t.string   "password_salt", :default => "", :null => false
  end

  create_table "colleges", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "city"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "coupons", :force => true do |t|
    t.string   "code",                          :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "distributor_id"
    t.integer  "stock",          :default => 0
    t.integer  "value"
  end

  add_index "coupons", ["distributor_id"], :name => "index_coupons_on_distributor_id"

  create_table "coupons_users", :force => true do |t|
    t.integer "coupon_id", :null => false
    t.integer "user_id",   :null => false
  end

  add_index "coupons_users", ["user_id", "coupon_id"], :name => "index_coupons_users_on_user_id_and_coupon_id"

  create_table "distributors", :force => true do |t|
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "image_name"
  end

  create_table "guests", :force => true do |t|
    t.string   "first_name",               :default => "", :null => false
    t.string   "last_name",                :default => "", :null => false
    t.string   "email",                    :default => "", :null => false
    t.string   "mobile",     :limit => 20
    t.integer  "college_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "first_name",                           :default => "", :null => false
    t.string   "last_name",                            :default => "", :null => false
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "provider"
    t.float    "authid"
    t.string   "mobile",                 :limit => 20
    t.integer  "college_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "points"
  end

  add_index "users", ["college_id"], :name => "index_users_on_college_id"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wishlists", :force => true do |t|
    t.integer "book_group_id", :null => false
    t.integer "user_id",       :null => false
  end

  add_index "wishlists", ["book_group_id", "user_id"], :name => "index_wishlists_on_book_group_id_and_user_id"

end
