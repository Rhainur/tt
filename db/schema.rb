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

ActiveRecord::Schema.define(version: 20140124092516) do

  create_table "games", force: true do |t|
    t.integer "match_id"
    t.integer "winner_id"
    t.integer "loser_id"
  end

  add_index "games", ["match_id"], name: "index_games_on_match_id", using: :btree

  create_table "matches", force: true do |t|
    t.date     "match_date"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loser_id"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rating_changes", force: true do |t|
    t.integer  "match_id"
    t.integer  "player_id"
    t.integer  "change"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_changes", ["match_id"], name: "index_rating_changes_on_match_id", using: :btree
  add_index "rating_changes", ["player_id"], name: "index_rating_changes_on_player_id", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["game_id"], name: "index_scores_on_game_id", using: :btree
  add_index "scores", ["player_id"], name: "index_scores_on_player_id", using: :btree

end