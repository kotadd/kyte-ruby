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

ActiveRecord::Schema.define(version: 20180106111153) do

  create_table "genres", force: :cascade do |t|
    t.string "user_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "title"
    t.date "date"
    t.time "time_from"
    t.time "time_to"
    t.string "place"
    t.integer "budget"
    t.integer "max_member"
    t.integer "genre_id"
    t.string "image_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_name"
    t.string "password_digest"
    t.integer "favorite1"
    t.integer "favorite2"
    t.integer "favorite3"
  end

end
