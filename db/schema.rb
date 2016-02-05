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

ActiveRecord::Schema.define(version: 20160204020746) do

  create_table "follows", force: :cascade do |t|
    t.text     "ig_user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "instagram_account_id"
  end

  add_index "follows", ["instagram_account_id"], name: "index_follows_on_instagram_account_id"

  create_table "instagram_accounts", force: :cascade do |t|
    t.string   "username"
    t.text     "auth_token"
    t.text     "ig_id"
    t.text     "profile_picture"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
