#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  tp workspace.channels, 'slack_id', 'name', 'member_count', 'topic'

  tp workspace.users, 'slack_id', 'name', 'real_name', 'status_text', 'status_emoji'

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME