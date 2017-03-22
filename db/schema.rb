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

ActiveRecord::Schema.define(version: 20170322185606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approvals", force: :cascade do |t|
    t.integer  "donation_id"
    t.string   "approver_type"
    t.integer  "approver_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["approver_type", "approver_id"], name: "index_approvals_on_approver_type_and_approver_id", using: :btree
    t.index ["donation_id"], name: "index_approvals_on_donation_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "coaches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "fellow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fellow_id"], name: "index_coaches_on_fellow_id", using: :btree
    t.index ["user_id"], name: "index_coaches_on_user_id", using: :btree
  end

  create_table "donations", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "amount"
    t.string   "pan"
    t.text     "address"
    t.integer  "volunteer_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "tax_claim",    default: false
    t.index ["volunteer_id"], name: "index_donations_on_volunteer_id", using: :btree
  end

  create_table "fellows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "national_finance_head_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["national_finance_head_id"], name: "index_fellows_on_national_finance_head_id", using: :btree
    t.index ["user_id"], name: "index_fellows_on_user_id", using: :btree
  end

  create_table "national_finance_heads", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_national_finance_heads_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "volunteers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_volunteers_on_coach_id", using: :btree
    t.index ["user_id"], name: "index_volunteers_on_user_id", using: :btree
  end

  add_foreign_key "approvals", "donations"
  add_foreign_key "coaches", "fellows"
  add_foreign_key "coaches", "users"
  add_foreign_key "donations", "volunteers"
  add_foreign_key "fellows", "national_finance_heads"
  add_foreign_key "fellows", "users"
  add_foreign_key "national_finance_heads", "users"
  add_foreign_key "volunteers", "coaches"
  add_foreign_key "volunteers", "users"
end
