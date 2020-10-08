#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'workspace'
require 'table_print'

def get_command
  puts 'What would you like to do? '
  puts "1 = list users\n2 = list channels \n3 = quit/q"
  command = gets.chomp
  command
end

def main
  puts 'Welcome to the Ada Slack CLI!'
  workspace = Workspace.new

  command = get_command
  while command != '3' && command != "quit" && command != 'q'
    case command
    when '1', 'list users'
      tp workspace.users, 'slack_id', 'name', 'real_name'
    when '2', 'list channels'
      tp workspace.channels, 'name', 'topic', 'member_count', 'slack_id'
    else
      puts 'Please only select the commands from the list'
    end
    command = get_command
  end
  puts 'Thank you for using the Ada Slack CLI'
end

main if __FILE__ == $PROGRAM_NAME
