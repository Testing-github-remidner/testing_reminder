

def get_slack_user(github_username, client)
  response = RestClient.get("https://api.github.com/users/#{github_username}", { 'Accept': 'application/vnd.github.v3+json' })
  user_data = JSON.parse(response.body)
  puts "user_data #{user_data}"
  email_address = user_data['email']

  result = client.users_lookupByEmail(email: email_address)
  puts "result #{result}"
  slack_username = result.user.name
end