require 'slack'

Slack.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
end

client = Slack::Web::Client.new

pull_request_url = ENV['GITHUB_SERVER_URL'] + '/' + ENV['GITHUB_REPOSITORY'] + '/pull/' + ENV['GITHUB_REF'].split('/').last
message = "New comment on your pull request <#{pull_request_url}|#{ENV['GITHUB_HEAD_REF']}> by #{ENV['GITHUB_ACTOR']}: \"#{ENV['COMMENT_BODY']}\""

puts "pull_request_url #{pull_request_url}"
puts "message #{message}"
puts "slack token #{ENV['SLACK_BOT_TOKEN']}"

channel = ENV['SLACK_CHANNEL_ID']

puts "channel id #{channel}"
client.chat_postMessage(channel: channel, text: message)