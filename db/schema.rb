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

ActiveRecord::Schema.define(version: 20170131085531) do

  create_table "coaches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "fellow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fellow_id"], name: "index_coaches_on_fellow_id"
  end

  create_table "donations", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "amount"
    t.string   "pan"
    t.text     "address"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "volunteer_id"
    t.index ["volunteer_id"], name: "index_donations_on_volunteer_id"
  end

  create_table "fellows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "national_finance_head_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["national_finance_head_id"], name: "index_fellows_on_national_finance_head_id"
  end

  create_table "national_finance_heads", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "phone"
  end

  create_table "volunteers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_volunteers_on_coach_id"
  end

end
