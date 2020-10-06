# frozen_string_literal: true

require 'dotenv'
require 'httparty'

Dotenv.load

def main
  puts 'Welcome to the Ada Slack CLI!'

  response = HTTParty.get('https://slack.com/api/conversations.list', query: {
                             token: ENV['SLACK_TOKEN']
                           })
  #response = HTTParty.post('https://api.slack.com/methods/conversations.list', body: {
  #                           token: ENV['SLACK_API_TOKEN'],
  #                           channel: 'test-channel2'
  #                           text: 'This is my test~!'
  #                         })


  if response.code != 200 || response.message != 'OK'
    puts 'There was a problem!'
    puts "The code was #{response.code} and the message was #{response.message}"
  end

  response['channels'].each do |channel|
    puts channel['name']
  end

  puts 'Thank you for using the Ada Slack CLI'
end

main if __FILE__ == $PROGRAM_NAME