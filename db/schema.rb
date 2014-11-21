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

ActiveRecord::Schema.define(version: 20141115005925) do

  create_table "factions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.boolean  "public_vote"
    t.boolean  "public_lancelot_switch"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assassinated_assignment_id"
  end

  create_table "ladies", force: true do |t|
    t.integer  "mission_id"
    t.integer  "source_id"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ladies", ["mission_id"], name: "index_ladies_on_mission_id"

  create_table "lancelots", force: true do |t|
    t.boolean  "switched"
    t.integer  "mission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lancelots", ["mission_id"], name: "index_lancelots_on_mission_id"

  create_table "mission_capacities", force: true do |t|
    t.integer  "player_count"
    t.integer  "mission_number"
    t.integer  "capacity"
    t.integer  "fail_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missions", force: true do |t|
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mission_number"
  end

  add_index "missions", ["game_id"], name: "index_missions_on_game_id"

  create_table "player_assignments", force: true do |t|
    t.integer  "seat_number"
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_assignments", ["game_id"], name: "index_player_assignments_on_game_id"
  add_index "player_assignments", ["player_id"], name: "index_player_assignments_on_player_id"
  add_index "player_assignments", ["role_id"], name: "index_player_assignments_on_role_id"

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_hash"
    t.string   "password_salt"
  end

  create_table "role_relationships", force: true do |t|
    t.integer  "role_id"
    t.integer  "revealed_role_id"
    t.boolean  "revealed_faction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "faction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "roles", ["faction_id"], name: "index_roles_on_faction_id"

  create_table "team_assignments", force: true do |t|
    t.boolean  "pass"
    t.integer  "team_id"
    t.integer  "player_assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_assignments", ["player_assignment_id"], name: "index_team_assignments_on_player_assignment_id"
  add_index "team_assignments", ["team_id"], name: "index_team_assignments_on_team_id"

  create_table "team_votes", force: true do |t|
    t.boolean  "approve"
    t.integer  "team_id"
    t.integer  "player_assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_votes", ["player_assignment_id"], name: "index_team_votes_on_player_assignment_id"
  add_index "team_votes", ["team_id"], name: "index_team_votes_on_team_id"

  create_table "teams", force: true do |t|
    t.integer  "mission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["mission_id"], name: "index_teams_on_mission_id"

end
