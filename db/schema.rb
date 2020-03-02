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

ActiveRecord::Schema.define(version: 2020_03_02_184835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_olympians", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "olympian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_olympians_on_event_id"
    t.index ["olympian_id"], name: "index_event_olympians_on_olympian_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.bigint "sport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sport_id"], name: "index_events_on_sport_id"
  end

  create_table "medalists", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "olympian_id"
    t.integer "medal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_medalists_on_event_id"
    t.index ["olympian_id"], name: "index_medalists_on_olympian_id"
  end

  create_table "olympians", force: :cascade do |t|
    t.string "name"
    t.integer "sex", default: 0
    t.integer "age"
    t.integer "height"
    t.integer "weight"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_olympians_on_team_id"
  end

  create_table "sport_olympians", force: :cascade do |t|
    t.bigint "sport_id"
    t.bigint "olympian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["olympian_id"], name: "index_sport_olympians_on_olympian_id"
    t.index ["sport_id"], name: "index_sport_olympians_on_sport_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "event_olympians", "events"
  add_foreign_key "event_olympians", "olympians"
  add_foreign_key "events", "sports"
  add_foreign_key "medalists", "events"
  add_foreign_key "medalists", "olympians"
  add_foreign_key "olympians", "teams"
  add_foreign_key "sport_olympians", "olympians"
  add_foreign_key "sport_olympians", "sports"
end
