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

ActiveRecord::Schema.define(version: 20140421152113) do

  create_table "admins", force: true do |t|
    t.integer "user_id"
    t.integer "permission"
  end

  create_table "battle_votes", force: true do |t|
    t.integer "battle_id"
    t.string  "voter_ip"
    t.integer "choice"
    t.integer "user_id"
  end

  create_table "battles", force: true do |t|
    t.integer  "oponent1_id"
    t.integer  "oponent2_id"
    t.integer  "oponent1_votes", default: 0
    t.integer  "oponent2_votes", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
    t.boolean  "finished",       default: false
  end

  create_table "pictures", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "tournament_id"
    t.boolean  "checked",             default: false
    t.boolean  "in_battle",           default: false
  end

  create_table "pictures_tournaments", force: true do |t|
    t.integer "tourtnament_id"
    t.integer "picture_id"
  end

  create_table "subscriptions", force: true do |t|
    t.integer "battle_id"
    t.integer "user_id"
  end

  create_table "tournaments", force: true do |t|
    t.integer  "winner_id"
    t.integer  "state"
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked",    default: false
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "city"
  end

end
