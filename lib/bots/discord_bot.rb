# lib/bots/discord_bot.rb
require 'discordrb'

class DiscordBot
  def initialize(token, client_id)
    @bot = Discordrb::Bot.new token: token, client_id: client_id

  def run
    @bot.run
  end
end
end
