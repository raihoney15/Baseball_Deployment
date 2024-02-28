# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_28_060550) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_assignments_on_role_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "batting_stats", force: :cascade do |t|
    t.integer "run"
    t.bigint "event_id", null: false
    t.bigint "scoreboard_id", null: false
    t.bigint "team_id"
    t.bigint "opponent_team_id"
    t.bigint "rooster_id"
    t.bigint "opponent_rooster_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_batting_stats_on_event_id"
    t.index ["opponent_rooster_id"], name: "index_batting_stats_on_opponent_rooster_id"
    t.index ["opponent_team_id"], name: "index_batting_stats_on_opponent_team_id"
    t.index ["rooster_id"], name: "index_batting_stats_on_rooster_id"
    t.index ["scoreboard_id"], name: "index_batting_stats_on_scoreboard_id"
    t.index ["team_id"], name: "index_batting_stats_on_team_id"
  end

  create_table "commentaries", force: :cascade do |t|
    t.text "text"
    t.bigint "rooster_id"
    t.bigint "opponent_rooster_id"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rooster_name"
    t.string "move_name"
    t.index ["event_id"], name: "index_commentaries_on_event_id"
    t.index ["opponent_rooster_id"], name: "index_commentaries_on_opponent_rooster_id"
    t.index ["rooster_id"], name: "index_commentaries_on_rooster_id"
  end

  create_table "event_innings", force: :cascade do |t|
    t.integer "inning_number"
    t.boolean "top"
    t.boolean "bottom"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_innings_on_event_id"
  end

  create_table "event_setups", force: :cascade do |t|
    t.integer "inning_rounds"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_setups_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "game_type"
    t.boolean "home_team"
    t.boolean "away_team"
    t.date "start_date"
    t.string "location"
    t.integer "belongs"
    t.string "memo"
    t.boolean "is_live"
    t.integer "winning_team_id"
    t.bigint "user_id", null: false
    t.bigint "tournament_id", null: false
    t.bigint "team_id", null: false
    t.bigint "opponent_team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opponent_team_id"], name: "index_events_on_opponent_team_id"
    t.index ["team_id"], name: "index_events_on_team_id"
    t.index ["tournament_id"], name: "index_events_on_tournament_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email"
    t.boolean "accepted", default: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_invitations_on_tournament_id"
  end

  create_table "moves", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opponent_roosters", force: :cascade do |t|
    t.string "name"
    t.integer "jersey_number"
    t.bigint "user_id", null: false
    t.bigint "tournament_id", null: false
    t.bigint "opponent_team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opponent_team_id"], name: "index_opponent_roosters_on_opponent_team_id"
    t.index ["tournament_id"], name: "index_opponent_roosters_on_tournament_id"
    t.index ["user_id"], name: "index_opponent_roosters_on_user_id"
  end

  create_table "opponent_team_line_ups", force: :cascade do |t|
    t.integer "batter_order"
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.bigint "opponent_rooster_id", null: false
    t.bigint "opponent_team_id", null: false
    t.bigint "position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id", null: false
    t.index ["event_id"], name: "index_opponent_team_line_ups_on_event_id"
    t.index ["opponent_rooster_id"], name: "index_opponent_team_line_ups_on_opponent_rooster_id"
    t.index ["opponent_team_id"], name: "index_opponent_team_line_ups_on_opponent_team_id"
    t.index ["position_id"], name: "index_opponent_team_line_ups_on_position_id"
    t.index ["tournament_id"], name: "index_opponent_team_line_ups_on_tournament_id"
    t.index ["user_id"], name: "index_opponent_team_line_ups_on_user_id"
  end

  create_table "opponent_teams", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.bigint "user_id", null: false
    t.bigint "tournament_id", null: false
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_opponent_teams_on_team_id"
    t.index ["tournament_id"], name: "index_opponent_teams_on_tournament_id"
    t.index ["user_id"], name: "index_opponent_teams_on_user_id"
  end

  create_table "pitching_stats", force: :cascade do |t|
    t.integer "pitch"
    t.bigint "event_id", null: false
    t.bigint "scoreboard_id", null: false
    t.bigint "team_id"
    t.bigint "opponent_team_id"
    t.bigint "rooster_id"
    t.bigint "opponent_rooster_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_pitching_stats_on_event_id"
    t.index ["opponent_rooster_id"], name: "index_pitching_stats_on_opponent_rooster_id"
    t.index ["opponent_team_id"], name: "index_pitching_stats_on_opponent_team_id"
    t.index ["rooster_id"], name: "index_pitching_stats_on_rooster_id"
    t.index ["scoreboard_id"], name: "index_pitching_stats_on_scoreboard_id"
    t.index ["team_id"], name: "index_pitching_stats_on_team_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "position_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooster_positions", force: :cascade do |t|
    t.integer "catcher"
    t.integer "fourth_base"
    t.integer "first_base"
    t.integer "second_base"
    t.integer "third_base"
    t.integer "pitcher"
    t.integer "shortstop"
    t.integer "rightfield"
    t.integer "leftfield"
    t.integer "centerfield"
    t.bigint "user_id", null: false
    t.bigint "scoreboard_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scoreboard_id"], name: "index_rooster_positions_on_scoreboard_id"
    t.index ["user_id"], name: "index_rooster_positions_on_user_id"
  end

  create_table "roosters", force: :cascade do |t|
    t.string "name"
    t.integer "jersey_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.bigint "user_id"
    t.bigint "tournament_id"
    t.index ["team_id"], name: "index_roosters_on_team_id"
    t.index ["tournament_id"], name: "index_roosters_on_tournament_id"
    t.index ["user_id"], name: "index_roosters_on_user_id"
  end

  create_table "scoreboards", force: :cascade do |t|
    t.integer "balls"
    t.integer "run"
    t.integer "strike"
    t.integer "out"
    t.boolean "home_team"
    t.boolean "home_away"
    t.bigint "event_id", null: false
    t.bigint "event_inning_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_scoreboards_on_event_id"
    t.index ["event_inning_id"], name: "index_scoreboards_on_event_inning_id"
  end

  create_table "starts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_line_ups", force: :cascade do |t|
    t.integer "batter_order"
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.bigint "rooster_id", null: false
    t.bigint "team_id", null: false
    t.bigint "position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id", null: false
    t.index ["event_id"], name: "index_team_line_ups_on_event_id"
    t.index ["position_id"], name: "index_team_line_ups_on_position_id"
    t.index ["rooster_id"], name: "index_team_line_ups_on_rooster_id"
    t.index ["team_id"], name: "index_team_line_ups_on_team_id"
    t.index ["tournament_id"], name: "index_team_line_ups_on_tournament_id"
    t.index ["user_id"], name: "index_team_line_ups_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "tournament_id"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tournaments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "pin"
    t.datetime "pin_sent_at"
    t.boolean "verified", default: false
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.string "string"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assignments", "roles"
  add_foreign_key "assignments", "users"
  add_foreign_key "batting_stats", "events"
  add_foreign_key "batting_stats", "opponent_roosters"
  add_foreign_key "batting_stats", "opponent_teams"
  add_foreign_key "batting_stats", "roosters"
  add_foreign_key "batting_stats", "scoreboards"
  add_foreign_key "batting_stats", "teams"
  add_foreign_key "commentaries", "events"
  add_foreign_key "commentaries", "opponent_roosters"
  add_foreign_key "commentaries", "roosters"
  add_foreign_key "event_innings", "events"
  add_foreign_key "event_setups", "events"
  add_foreign_key "events", "opponent_teams"
  add_foreign_key "events", "teams"
  add_foreign_key "events", "tournaments"
  add_foreign_key "events", "users"
  add_foreign_key "invitations", "tournaments"
  add_foreign_key "opponent_roosters", "opponent_teams"
  add_foreign_key "opponent_roosters", "tournaments"
  add_foreign_key "opponent_roosters", "users"
  add_foreign_key "opponent_team_line_ups", "events"
  add_foreign_key "opponent_team_line_ups", "opponent_roosters"
  add_foreign_key "opponent_team_line_ups", "opponent_teams"
  add_foreign_key "opponent_team_line_ups", "positions"
  add_foreign_key "opponent_team_line_ups", "tournaments"
  add_foreign_key "opponent_team_line_ups", "users"
  add_foreign_key "opponent_teams", "teams"
  add_foreign_key "opponent_teams", "tournaments"
  add_foreign_key "opponent_teams", "users"
  add_foreign_key "pitching_stats", "events"
  add_foreign_key "pitching_stats", "opponent_roosters"
  add_foreign_key "pitching_stats", "opponent_teams"
  add_foreign_key "pitching_stats", "roosters"
  add_foreign_key "pitching_stats", "scoreboards"
  add_foreign_key "pitching_stats", "teams"
  add_foreign_key "rooster_positions", "scoreboards"
  add_foreign_key "rooster_positions", "users"
  add_foreign_key "roosters", "teams"
  add_foreign_key "roosters", "tournaments"
  add_foreign_key "roosters", "users"
  add_foreign_key "scoreboards", "event_innings"
  add_foreign_key "scoreboards", "events"
  add_foreign_key "team_line_ups", "events"
  add_foreign_key "team_line_ups", "positions"
  add_foreign_key "team_line_ups", "roosters"
  add_foreign_key "team_line_ups", "teams"
  add_foreign_key "team_line_ups", "tournaments"
  add_foreign_key "team_line_ups", "users"
  add_foreign_key "teams", "tournaments"
  add_foreign_key "teams", "users"
  add_foreign_key "tournaments", "users"
end
