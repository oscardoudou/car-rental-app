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

ActiveRecord::Schema.define(version: 20170923134014) do

  create_table "cars", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image_url"
    t.decimal "price", precision: 8, scale: 2
    t.string "status"
    t.string "license_plate"
    t.string "model"
    t.string "manufactor"
    t.string "style"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "reservation_id"
    t.integer "car_id"
    t.integer "user_id"
    t.string "name"
    t.integer "tel"
    t.text "address"
    t.string "email"
    t.string "pay_type"
    t.string "status"
    t.datetime "checkout_time"
    t.datetime "return_time"
    t.datetime "real_checkout_time"
    t.datetime "real_return_time"
    t.decimal "charge", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "email"
    t.integer "car_id"
    t.integer "user_id"
    t.integer "tel"
    t.string "status"
    t.datetime "reserve_time"
    t.datetime "checkout_time"
    t.datetime "return_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.boolean "sadmin", default: false
  end

end
