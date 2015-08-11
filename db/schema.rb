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

ActiveRecord::Schema.define(version: 20150811185949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assassins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "in_progress", default: false
    t.boolean  "finished",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "admin_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "assassin_id"
    t.integer "game_id"
    t.boolean "alive",       default: true
    t.integer "kills",       default: 0
  end

  add_index "players", ["assassin_id"], name: "index_players_on_assassin_id", using: :btree
  add_index "players", ["game_id"], name: "index_players_on_game_id", using: :btree

end
