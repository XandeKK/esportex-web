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

ActiveRecord::Schema[7.0].define(version: 2022_11_19_203929) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_categories", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_room_id", null: false
    t.string "role", default: "Normal", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_chat_participants_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_participants_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "bio", limit: 500
    t.bigint "chat_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_category_id"], name: "index_chat_rooms_on_chat_category_id"
  end

  create_table "game_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_comments_on_game_id"
    t.index ["user_id"], name: "index_game_comments_on_user_id"
  end

  create_table "game_participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_participants_on_game_id"
    t.index ["user_id"], name: "index_game_participants_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title", limit: 100, default: ""
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "address", null: false
    t.string "info", limit: 500
    t.bigint "user_id", null: false
    t.bigint "sport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sport_id"], name: "index_games_on_sport_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name", limit: 26, null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "username", limit: 36, null: false
    t.string "bio", limit: 500
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  add_foreign_key "chat_participants", "chat_rooms"
  add_foreign_key "chat_participants", "users"
  add_foreign_key "chat_rooms", "chat_categories"
  add_foreign_key "game_comments", "games"
  add_foreign_key "game_comments", "users"
  add_foreign_key "game_participants", "games"
  add_foreign_key "game_participants", "users"
  add_foreign_key "games", "sports"
  add_foreign_key "games", "users"
end
