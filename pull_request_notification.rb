require 'slack'

Slack.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
end

client = Slack::Web::Client.new

message = "A review has been requested for the pull request: <#{ENV['PULL_REQUEST_URL']}|#{ENV['PULL_REQUEST_TITLE']}> by #{ENV['REQUESTED_REVIEWER']}"
channel = ENV['SLACK_CHANNEL_ID']

client.chat_postMessage(channel: channel, text: message)
