require 'faker'

# Seed categories
categories = Category.all

# Define the number of products you want to seed
number_of_products = 100

# Seed products
number_of_products.times do
  category = categories.sample  # Select a random category for each product
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock: Faker::Number.between(from: 1, to: 100),
    category: category
  )
end

puts "Seed data for products created successfully!"
