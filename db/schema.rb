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

ActiveRecord::Schema.define(version: 2019_09_27_012323) do

  create_table "auto_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vehicle_id"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auto_histories_on_user_id"
    t.index ["vehicle_id"], name: "index_auto_histories_on_vehicle_id"
  end

  create_table "auto_history_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "auto_history_id"
    t.bigint "type_of_repair_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auto_history_id"], name: "index_auto_history_types_on_auto_history_id"
    t.index ["type_of_repair_id"], name: "index_auto_history_types_on_type_of_repair_id"
  end

  create_table "bookings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "is_active"
    t.date "repair_date"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "day_of_business_hours", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "day_of_week_id"
    t.time "open_at"
    t.time "close_at"
    t.boolean "is_overlap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_of_week_id"], name: "index_day_of_business_hours_on_day_of_week_id"
  end

  create_table "day_of_weeks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "day_of_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "type_of_repairs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.integer "repair_time"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "make"
    t.string "model"
    t.string "color"
    t.date "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vin"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "auto_histories", "users"
  add_foreign_key "auto_histories", "vehicles"
  add_foreign_key "auto_history_types", "auto_histories"
  add_foreign_key "auto_history_types", "type_of_repairs"
  add_foreign_key "bookings", "users"
  add_foreign_key "day_of_business_hours", "day_of_weeks"
  add_foreign_key "vehicles", "users"
end
