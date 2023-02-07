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

ActiveRecord::Schema[7.0].define(version: 2023_02_02_233725) do
  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.integer "kind"
    t.string "url"
    t.integer "status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_media_on_status_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.text "body"
    t.integer "user_id", null: false
    t.integer "replied_to_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["replied_to_status_id"], name: "index_statuses_on_replied_to_status_id"
    t.index ["user_id"], name: "index_statuses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "handle"
    t.string "display_name"
    t.text "bio"
    t.date "born_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "media", "statuses"
  add_foreign_key "statuses", "statuses", column: "replied_to_status_id"
  add_foreign_key "statuses", "users"
end
