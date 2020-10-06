# frozen_string_literal: true

require 'dotenv'
require 'httparty'


Dotenv.load

def main
  puts 'Welcome to the Ada Slack CLI!'
  puts ENV['SLACK_TOKEN']

  response = HTTParty.get('https://slack.com/api/users.list', query: {
                            token: ENV['SLACK_TOKEN']
                          })
  # response = HTTParty.post('https://api.slack.com/methods/conversations.list', body: {
  #                            token: ENV['SLACK_API_TOKEN'],
  #                            channel: 'test-channel2', # this is our test channel, we need to create one.
  #                            text: 'This is my test~!'
  #                          })

  pp response
  puts 'Thank you for using the Ada Slack CLI'
end

main if __FILE__ == $PROGRAM_NAME
