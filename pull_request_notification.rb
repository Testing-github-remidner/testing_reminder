require 'slack'

Slack.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
end

client = Slack::Web::Client.new
message = "A review has been requested for the pull request: <#{ENV['PULL_REQUEST_URL']}|#{ENV['PULL_REQUEST_TITLE']}> by <@#{ENV['REQUESTED_REVIEWER']}>"
puts "message #{message}"
slack_user = get_slack_user
puts "slack_user #{slack_user}"

channel = ENV['SLACK_CHANNEL_ID']

client.chat_postMessage(channel: channel, text: message)

def get_slack_user
  github_username = ENV['GITHUB_ACTOR']
  response = RestClient.get("https://api.github.com/users/#{github_username}", { 'Accept': 'application/vnd.github.v3+json' })
  user_data = JSON.parse(response.body)
  email_address = user_data['email']

  result = client.users_lookupByEmail(email: email_address)
  puts "result #{result}"
  slack_username = result.user.name
end