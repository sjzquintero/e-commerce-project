require 'faker'

# Limpiar la base de datos para evitar duplicados en desarrollo
Category.destroy_all

# Crear categorías
categories = [
  { name: 'T-Shirts and Tops', description: 'Comfortable and stylish urban tops.' },
  { name: 'Jeans and Pants', description: 'Variety of jeans and pants for any occasion.' },
  { name: 'Hoodies and Sweatshirts', description: 'Casual and trendy hoodies and sweatshirts.' },
  { name: 'Jackets and Coats', description: 'Stylish jackets and coats for urban wear.' },
  { name: 'Footwear', description: 'Urban shoes and sneakers.' },
  { name: 'Accessories', description: 'Complete your look with our accessories.' }
]

# Crear las categorías en la base de datos
categories.each do |category|
  Category.create(category)
end

puts "Categories created successfully."

# Sembrar productos para cada categoría
categories.each do |category|
  17.times do
    category_record = Category.find_by(name: category[:name])
    Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph(sentence_count: 2),
      price: Faker::Commerce.price(range: 10.0..100.0),
      stock: Faker::Number.between(from: 1, to: 100),
      category_id: category_record.id  # Usar category_id en lugar de category
    )
  end
end

puts "Seed data for products created successfully!"
