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

ActiveRecord::Schema.define(version: 20180814001418) do

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessonreservations", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lessonreservations", ["user_id"], name: "index_lessonreservations_on_user_id"

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.integer  "req_num"
    t.text     "summary"
    t.text     "content"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id"

  create_table "myfunspots", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.string   "address"
    t.string   "phone_number"
    t.string   "email"
    t.string   "website"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "myfunspots", ["user_id"], name: "index_myfunspots_on_user_id"

  create_table "regularreservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "myfunspot_id"
    t.datetime "start"
    t.datetime "end"
    t.integer  "dow"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "regularreservations", ["myfunspot_id"], name: "index_regularreservations_on_myfunspot_id"
  add_index "regularreservations", ["user_id"], name: "index_regularreservations_on_user_id"

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "myfunspot_id"
    t.datetime "end"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "start"
  end

  add_index "reservations", ["myfunspot_id"], name: "index_reservations_on_myfunspot_id"
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "phone_number"
    t.string   "description"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
