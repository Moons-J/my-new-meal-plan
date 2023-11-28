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

puts "Deleting old records..."

Ingredient.destroy_all
Meal.destroy_all
User.destroy_all

puts "Reading base ingredients..."
require 'csv'

filepath = Rails.root.join("lib", "assets", "ingredients.csv")

CSV.foreach(filepath, headers: :first_row) do |row|
  BaseIngredient.create!(
    name: "#{row['name']}",
    calories: "#{row['calories']}",
    fats: "#{row['fats']}",
    satu_fats: "#{row['sat_fats']}",
    carbs: "#{row['carbs']}",
    protein: "#{row['protein']}",
  )
end
puts "Created #{BaseIngredient.count} base ingredients!"

puts "Creating users..."

emails = ["test1@email.com", "test2@email.com", "test3@email.com", "test4@email.com", "test5@email.com"]

emails.each do |email|
  user = User.create!(
    email: email,
    password: "123123",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user_name: Faker::Internet.username,
    height: rand(130..200),
    exercise_level: rand(1..5),
    weight: rand(30..160),
    birthday: "#{rand(1..30)}/#{rand(1..12)}/#{rand(1990..2005)}"
  )
  puts "#{user.ingredients.count} ingredients added to user with email: #{email}"

  puts "Creating meals..."

  number_meals = 10
  number_meals.times do
    meal = Meal.create!(
      name: Faker::Food.dish,
      comment: Faker::Food.description,
      user_id: user.id,
    )
    rand(3..10).times do
      MealIngredient.create!(
        amount: rand(10..150),
        meal_id: meal.id,
        ingredient_id: Ingredient.all.sample.id
      )
    end
  end

  puts "Created #{number_meals} meals!"
end
