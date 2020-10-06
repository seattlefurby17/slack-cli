#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  # response = HTTParty.get('https://slack.com/api/conversations.list', query: {
  #     token: ENV['SLACK_TOKEN']


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME