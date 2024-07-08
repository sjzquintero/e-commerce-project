# clean database ( to avoid duplicates on development)
Category.destroy_all

# Create categories
categories = [
  { name: 'T-Shirts and Tops', description: 'Comfortable and stylish urban tops.' },
  { name: 'Jeans and Pants', description: 'Variety of jeans and pants for any occasion.' },
  { name: 'Hoodies and Sweatshirts', description: 'Casual and trendy hoodies and sweatshirts.' },
  { name: 'Jackets and Coats', description: 'Stylish jackets and coats for urban wear.' },
  { name: 'Footwear', description: 'Urban shoes and sneakers.' },
  { name: 'Accessories', description: 'Complete your look with our accessories.' }
]

categories.each do |category|
  Category.create(category)
end

puts "Categories created successfully."
