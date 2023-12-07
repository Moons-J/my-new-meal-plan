# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require 'csv'

puts "Deleting old base ingredients..."
BaseIngredient.destroy_all
puts "Deleting old meal ingredients..."
MealIngredient.destroy_all
puts "Deleting old ingredients..."
Ingredient.destroy_all
puts "Deleting old meals..."
DailyPlanMeal.destroy_all
Meal.destroy_all
puts "Deleting old daily plans..."
DailyPlan.destroy_all
puts "Deleting old plannings"
Planning.destroy_all
puts "Deleting evidences of weight history..."
WeightHistory.destroy_all
puts "Deleting old users..."
User.destroy_all
puts "Everything destroyed!"

puts "Reading base ingredients..."

filepath = Rails.root.join("lib", "assets", "ingredients.csv")

CSV.foreach(filepath, headers: :first_row) do |row|
  BaseIngredient.create!(
    name: row[0].to_s,
    calories: row['calories'].to_s,
    fats: row['fats'].to_s,
    satu_fats: row['sat_fats'].to_s,
    carbs: row['carbs'].to_s,
    protein: row['protein'].to_s,
  )
end
puts "Created #{BaseIngredient.count} base ingredients!"

puts "Creating users..."

emails = ["test1@email.com", "test2@email.com", "test3@email.com", "test4@email.com", "test5@email.com"]
@sex = ["male", "female", "rather not say"]
@phase = ["gain", "maintain", "lose"]

emails.each do |email|
  user = User.create!(
    email: email,
    password: "123123",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user_name: Faker::Internet.username,
    sex: @sex.sample,
    phase: @phase.sample,
    height: rand(150..200),
    exercise_level: rand(1..5),
    weight: rand(60..110),
    birthday: "#{rand(1..30)}/#{rand(1..12)}/#{rand(1990..2005)}"
  )
  puts "#{user.ingredients.count} ingredients added to user with email: #{email}"

  puts "Creating meals..."

  number_meals = 10
  number_meals.times do
    meal = Meal.create!(
      name: Faker::Food.dish,
      comment: Faker::Food.description,
      user_id: user.id
    )
    rand(3..10).times do
      MealIngredient.create!(
        amount: rand(10..150),
        meal_id: meal.id,
        ingredient_id: meal.user.ingredients.sample.id
      )
    end
  end
  puts "Created #{number_meals} meals!"

  puts "Creating daily plans and daily plan meals..."
  rand(2..5).times do
    date = Faker::Date.between(from: 2.year.ago, to: Date.today)
    daily_plan = DailyPlan.create!(
      name: Faker::Food.dish,
      user_id: user.id,
      created_at: date,
      updated_at: date
    )

    meal_types = %w[Breakfast Lunch Dinner]
    meal_types.each do |meal_type|
      DailyPlanMeal.create!(
        meal_id: Meal.all.sample.id,
        daily_plan_id: daily_plan.id,
        meal_type: meal_type
      )
    end

    # rand(3).times do
    #   Planning.create!(
    #     date: Time.new,
    #     daily_plan_id: daily_plan.id,
    #     user_id: user.id,
    #     start_time: Time.new(
    #       Time.now.year,
    #       Time.now.month,
    #       Time.now.day,
    #       rand(8..23),
    #       rand(1..59),
    #       rand(1..59),
    #       Time.zone.name
    #     )
    #   )
    # end
  end
  puts "Created daily plans!"

  puts "Looking for some history..."
  number_days = 30
  (1..number_days).each do |day|
    WeightHistory.create!(
      weight: (80 - (day * 0.25) + rand(-0.5..0.5)).round(1),
      user_id: user.id,
      created_at: Time.new(Time.now.year, 11, day, 20, 2, 2, Time.zone.name)
    )
  end
  (1..(Time.now.day - 1)).each do |day|
    WeightHistory.create!(
      weight: (80 - ((30 + day) * 0.25) + rand(-0.5..0.5)).round(1),
      user_id: user.id,
      created_at: Time.new(Time.now.year, 12, day, 20, 2, 2, Time.zone.name)
    )
  end
  puts "I have found the weight history of the last #{number_days} days!"
end
