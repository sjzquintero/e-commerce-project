# config/initializers/discord_bot.rb
require 'discordrb'

if Rails.env.development? || Rails.env.production?
  token = ENV['DISCORD_BOT_TOKEN']
  client_id = ENV['DISCORD_CLIENT_ID']

  bot = Discordrb::Bot.new token: token, client_id: client_id

  bot.message(with_text: 'on sale') do |event|
    sale_products = Product.where('price < ?', 15).map(&:name).join(", ")
    if sale_products.present?
      event.respond "Products on sale: #{sale_products}"
    else
      event.respond "No products on sale."
    end
  end

  bot.run :async
end
