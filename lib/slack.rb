#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'workspace'
require 'table_print'

def get_command
  puts 'What would you like to do? '
  puts '1 = list users'
  puts '2 = list channels'
  puts '3 = select user'
  puts '4 = select channel'
  puts '5 = details'
  puts '6 = send message'
  puts '7 = quit/q'
  command = gets.chomp.downcase
  return command
end

def get_object_type
  puts 'Great! Do you want to select by name or ID?'
  puts '1. Name'
  puts '2. ID'
  command = gets.chomp.downcase
  loop do
    case command
    when '1', 'name'
      return 'name'
    when '2', 'id'
      return 'slack_id'
    else
      puts 'Please enter a valid choice!'
      command = gets.chomp.downcase
    end
  end
end

def message_sent(workspace)
  if workspace.selected
    puts 'What is your message?'
    message = gets.chomp
    begin
      success = workspace.selected.send_message(message)
    rescue SlackApiError => exception
      puts "Messages can not be send, #{exception.message}"
    end
    puts "Message \"#{message}\" was sent to #{workspace.selected.name}!" if success
  else
    puts 'Please select a user or channel first'
  end
end

def main
  puts 'Welcome to the Ada Slack CLI!'
  puts 'Buffering...'
  workspace = Workspace.new
  puts "We have #{workspace.channels.length} channels and #{workspace.users.length} users."

  command = get_command
  while command != '7' && command != 'quit' && command != 'q'
    case command
    when '1', 'list users'
      tp workspace.users, 'slack_id', 'name', 'real_name'

    when '2', 'list channels'
      tp workspace.channels, 'name', 'topic', 'member_count', 'slack_id'

    when '3', 'select user'
      type = get_object_type
      puts "Enter the #{type}:"
      input = gets.chomp
      if workspace.select_user(input, type)
        puts "User #{workspace.selected.name} selected!"
      else
        puts 'User not found! Please try again.'
      end

    when '4', 'select channel'
      type = get_object_type
      puts "Enter the #{type}:"
      input = gets.chomp
      if workspace.select_channel(input, type)
        puts "Channel #{workspace.selected.name} selected!"
      else
        puts 'Channel not found! Please try again.'
      end

    when '5', 'details'
      if workspace.selected
        puts workspace.selected.get_details
      else
        puts 'No user/channel selected. Select one and try again'
      end
    when '6', 'send message'
      message_sent(workspace)
    else
      puts 'Please only select the commands from the list'
    end
    command = get_command

  end
  puts 'Thank you for using the Ada Slack CLI'
end

main if __FILE__ == $PROGRAM_NAME
