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

ActiveRecord::Schema.define(version: 2023_05_24_072803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "zipcode"
    t.string "city"
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_addresses_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["iso"], name: "index_countries_on_iso"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "installations", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "installer_id", null: false
    t.bigint "address_id", null: false
    t.integer "panels_number", limit: 2
    t.integer "panels_type", limit: 2
    t.text "panels_ids", default: [], array: true
    t.integer "install_state", limit: 2, default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date", null: false
    t.index ["address_id"], name: "index_installations_on_address_id"
    t.index ["customer_id"], name: "index_installations_on_customer_id"
    t.index ["install_state"], name: "index_installations_on_install_state"
    t.index ["installer_id"], name: "index_installations_on_installer_id"
  end

  create_table "installers", force: :cascade do |t|
    t.string "name"
    t.string "siren"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["siren"], name: "index_installers_on_siren", unique: true
  end

  add_foreign_key "addresses", "countries"
  add_foreign_key "installations", "addresses"
  add_foreign_key "installations", "customers"
  add_foreign_key "installations", "installers"
end
