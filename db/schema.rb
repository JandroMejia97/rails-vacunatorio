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

ActiveRecord::Schema.define(version: 2021_11_12_125850) do

  create_table "applied_vaccines", force: :cascade do |t|
    t.string "lot_number"
    t.integer "applied_dose"
    t.integer "vaccine_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vaccine_id"], name: "index_applied_vaccines_on_vaccine_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "turns", force: :cascade do |t|
    t.date "date"
    t.integer "status", default: 0
    t.integer "user_id", null: false
    t.integer "campaign_id", null: false
    t.integer "vaccination_center_id", null: false
    t.integer "applied_vaccine_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applied_vaccine_id"], name: "index_turns_on_applied_vaccine_id", unique: true
    t.index ["campaign_id"], name: "index_turns_on_campaign_id"
    t.index ["user_id"], name: "index_turns_on_user_id"
    t.index ["vaccination_center_id"], name: "index_turns_on_vaccination_center_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "login_attempts_count", default: 0
    t.integer "document_number", null: false
    t.date "birthdate", null: false
    t.boolean "comorbidity", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vaccination_center_id"
    t.index ["vaccination_center_id"], name: "index_users_on_vaccination_center_id"
  end

  create_table "users_roles", primary_key: ["user_id", "role_id"], force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "vaccination_centers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vaccines", force: :cascade do |t|
    t.string "name", null: false
    t.integer "number_of_doses", default: 1
    t.integer "stock", default: 0
    t.integer "campaign_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_vaccines_on_campaign_id"
  end

  add_foreign_key "applied_vaccines", "vaccines"
  add_foreign_key "turns", "applied_vaccines"
  add_foreign_key "turns", "campaigns"
  add_foreign_key "turns", "users"
  add_foreign_key "turns", "vaccination_centers"
  add_foreign_key "vaccines", "campaigns"
end
