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

ActiveRecord::Schema.define(version: 2021_09_05_200631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sources", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "title"
    t.index ["user_id"], name: "index_sources_on_user_id"
  end

  create_table "sourcings", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_sourcings_on_source_id"
    t.index ["task_id"], name: "index_sourcings_on_task_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.date "deadline"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_steps_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", null: false
    t.text "description", null: false
    t.date "start", null: false
    t.date "deadline", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "statut"
    t.integer "priority"
    t.bigint "user_id"
    t.index ["task_name"], name: "index_tasks_on_task_name"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "bio"
    t.string "telephone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mentor", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "sources", "users"
  add_foreign_key "sourcings", "sources"
  add_foreign_key "sourcings", "tasks"
  add_foreign_key "steps", "tasks"
  add_foreign_key "tasks", "users"
end
