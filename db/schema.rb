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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151214114617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "shorturls", force: :cascade do |t|
    t.string   "original_url"
    t.string   "surl"
    t.integer  "visits_count", default: 0
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "shorturls", ["user_id", "original_url"], name: "index_shorturls_on_user_id_and_original_url", unique: true, using: :btree
  add_index "shorturls", ["user_id"], name: "index_shorturls_on_user_id", using: :btree

  create_table "shortvisits", force: :cascade do |t|
    t.string   "ip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "shorturl_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shortvisits", ["shorturl_id"], name: "index_shortvisits_on_shorturl_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",               null: false
    t.string   "email",              null: false
    t.string   "encrypted_password", null: false
    t.string   "password_salt"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "api_key"
  end

  add_index "users", ["api_key"], name: "index_users_on_api_key", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "shorturls", "users"
  add_foreign_key "shortvisits", "shorturls"
end
