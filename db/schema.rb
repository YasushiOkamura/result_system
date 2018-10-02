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

ActiveRecord::Schema.define(version: 2018_09_06_083437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.string "name"
    t.string "grade"
    t.string "sex"
    t.string "major"
    t.text "memo"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.string "kind"
  end

  create_table "decathlon_results", force: :cascade do |t|
    t.integer "total_score"
    t.integer "finish"
    t.integer "athlete_id"
    t.integer "tournament_id"
    t.string "grade"
    t.date "established_date"
    t.string "information"
    t.string "condition"
    t.integer "sprint_100m_id"
    t.integer "score_100m"
    t.integer "field_lj_id"
    t.integer "score_lj"
    t.integer "field_sp_id"
    t.integer "score_sp"
    t.integer "field_hj_id"
    t.integer "score_hj"
    t.integer "sprint_400m_id"
    t.integer "score_400m"
    t.integer "sprint_110mh_id"
    t.integer "score_110mh"
    t.integer "field_dt_id"
    t.integer "score_dt"
    t.integer "field_pj_id"
    t.integer "score_pj"
    t.integer "field_jt_id"
    t.integer "score_jt"
    t.integer "long_1500m_id"
    t.integer "score_1500m"
  end

  create_table "field_results", force: :cascade do |t|
    t.string "competition"
    t.float "result"
    t.float "wind"
    t.string "round"
    t.integer "finish"
    t.integer "athlete_id"
    t.integer "tournament_id"
    t.string "grade"
    t.date "established_date"
    t.string "information"
    t.string "condition"
    t.boolean "official"
  end

  create_table "load_results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "long_results", force: :cascade do |t|
    t.string "competition"
    t.bigint "result"
    t.string "round"
    t.string "group"
    t.string "rane"
    t.integer "finish"
    t.integer "athlete_id"
    t.integer "tournament_id"
    t.string "grade"
    t.date "established_date"
    t.string "information"
    t.string "condition"
    t.boolean "official"
  end

  create_table "managers", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "password_digest", null: false
  end

  create_table "relay_results", force: :cascade do |t|
    t.string "competition"
    t.bigint "result"
    t.string "round"
    t.string "group"
    t.string "rane"
    t.integer "finish"
    t.integer "first_athlete_id"
    t.integer "second_athlete_id"
    t.integer "third_athlete_id"
    t.integer "fourth_athlete_id"
    t.integer "tournament_id"
    t.string "first_athlete_grade"
    t.string "second_athlete_grade"
    t.string "third_athlete_grade"
    t.string "fourth_athlete_grade"
    t.date "established_date"
    t.string "information"
    t.string "condition"
    t.boolean "official"
  end

  create_table "short_results", force: :cascade do |t|
    t.string "competition"
    t.bigint "result"
    t.float "wind"
    t.string "round"
    t.string "group"
    t.string "rane"
    t.integer "finish"
    t.integer "athlete_id"
    t.integer "tournament_id"
    t.string "grade"
    t.date "established_date"
    t.string "information"
    t.string "condition"
    t.boolean "official"
    t.index ["athlete_id"], name: "index_short_results_on_athlete_id"
    t.index ["tournament_id"], name: "index_short_results_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.string "place"
    t.date "start_day"
    t.date "end_day"
  end

end
