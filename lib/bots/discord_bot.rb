# frozen_string_literal: true

# lib/bots/discord_bot.rb
require "discordrb"

# DiscordBot represents a bot that connects to Discord using the `discordrb` gem.
# It initializes the bot with a token and client ID, and provides a method to run
# the bot.
#
# Initialization:
# - `initialize(token, client_id)`: Constructs a new instance of the bot with the
#   given token and client ID.
#   - `token`: The authentication token for the Discord bot.
#   - `client_id`: The client ID of the Discord bot.
#
# Instance Methods:
# - `run`: Starts the bot and connects it to Discord.
class DiscordBot
  def initialize(token, client_id)
    @bot = Discordrb::Bot.new(token:, client_id:)
  end

  def run
    @bot.run
  end
end
