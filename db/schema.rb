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

ActiveRecord::Schema.define(version: 20140527192720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cohort_exercises", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "cohort_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cohorts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "google_maps_location"
    t.text     "directions"
  end

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.string   "github_repo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedback_entries", force: true do |t|
    t.integer  "recipient_id"
    t.text     "comment"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "viewed",       default: false
  end

  create_table "job_opportunities", force: true do |t|
    t.string   "company_name",     null: false
    t.string   "company_location"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_number"
    t.string   "salary"
    t.string   "job_status"
    t.string   "decision"
    t.string   "job_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "submissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.string   "github_repo_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submissions", ["exercise_id"], name: "index_submissions_on_exercise_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_username"
    t.string   "github_id"
    t.integer  "cohort_id"
    t.integer  "role_bit_mask",   default: 0
  end

  add_index "users", ["cohort_id"], name: "index_users_on_cohort_id", using: :btree

end
