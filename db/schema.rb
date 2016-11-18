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

ActiveRecord::Schema.define(version: 20161117132649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "restaurant_id",           null: false
    t.string   "comment"
    t.integer  "crowdedness",   limit: 2, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "demands", force: :cascade do |t|
    t.text     "free"
    t.string   "demand_restaurant"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "archive",           default: false, null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.text     "opinion"
    t.boolean  "archive",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "pressed_users", force: :cascade do |t|
    t.integer  "comment_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "renewals", force: :cascade do |t|
    t.string   "update_info"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "hurigana",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "start_hour"
    t.integer  "start_minute"
    t.integer  "end_hour"
    t.integer  "end_minute"
    t.string   "holiday"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               null: false
    t.string   "uid",                    null: false
    t.string   "nickname",               null: false
    t.string   "image_url",              null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "point",      default: 0, null: false
  end

  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
