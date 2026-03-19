# frozen_string_literal: true

require 'line/bot'

def line_bot_client
  Line::Bot::Client.new do |config|
    config.channel_secret = Rails.application.credentials.line[:channel_secret]
    config.channel_token = Rails.application.credentials.line[:channel_token]
  end
end
