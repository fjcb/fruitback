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

ActiveRecord::Schema.define(:version => 20130226143229) do

  create_table "comments", :force => true do |t|
    t.string   "text",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "idea_id",    :null => false
    t.integer  "user_id",    :null => false
  end

  add_index "comments", ["idea_id"], :name => "index_comments_on_idea_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "ideas", :force => true do |t|
    t.string   "title",                      :null => false
    t.string   "description",                :null => false
    t.integer  "score",       :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "user_id"
    t.integer  "site_id"
  end

  add_index "ideas", ["site_id"], :name => "index_ideas_on_site_id"
  add_index "ideas", ["user_id"], :name => "index_ideas_on_user_id"

  create_table "responses", :force => true do |t|
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "idea_id",    :null => false
    t.integer  "user_id",    :null => false
    t.integer  "state_id",   :null => false
  end

  add_index "responses", ["idea_id"], :name => "index_responses_on_idea_id"
  add_index "responses", ["state_id"], :name => "index_responses_on_state_id"
  add_index "responses", ["user_id"], :name => "index_responses_on_user_id"

  create_table "sites", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "sites", ["user_id"], :name => "index_sites_on_user_id"

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false, :null => false
    t.boolean  "customer",               :default => false, :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "score",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "idea_id",                   :null => false
    t.integer  "user_id",                   :null => false
  end

  add_index "votes", ["idea_id"], :name => "index_votes_on_idea_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
