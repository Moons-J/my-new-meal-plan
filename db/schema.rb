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

ActiveRecord::Schema[7.1].define(version: 2023_11_28_121319) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "calories"
    t.float "fats"
    t.float "satu_fats"
    t.float "carbs"
    t.float "protein"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_plan_meals", force: :cascade do |t|
    t.string "meal_type"
    t.bigint "meal_id", null: false
    t.bigint "daily_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_plan_id"], name: "index_daily_plan_meals_on_daily_plan_id"
    t.index ["meal_id"], name: "index_daily_plan_meals_on_meal_id"
  end

  create_table "daily_plans", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_plans_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "calories"
    t.float "fats"
    t.float "satu_fats"
    t.float "carbs"
    t.float "protein"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "meal_ingredients", force: :cascade do |t|
    t.integer "amount"
    t.bigint "meal_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_meal_ingredients_on_ingredient_id"
    t.index ["meal_id"], name: "index_meal_ingredients_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "plannings", force: :cascade do |t|
    t.date "date"
    t.boolean "exercise"
    t.bigint "daily_plan_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_plan_id"], name: "index_plannings_on_daily_plan_id"
    t.index ["user_id"], name: "index_plannings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.date "birthday"
    t.integer "height"
    t.integer "exercise_level"
    t.float "weight"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_plan_meals", "daily_plans"
  add_foreign_key "daily_plan_meals", "meals"
  add_foreign_key "daily_plans", "users"
  add_foreign_key "ingredients", "users"
  add_foreign_key "meal_ingredients", "ingredients"
  add_foreign_key "meal_ingredients", "meals"
  add_foreign_key "meals", "users"
  add_foreign_key "plannings", "daily_plans"
  add_foreign_key "plannings", "users"
end
