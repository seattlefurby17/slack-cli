# frozen_string_literal: true
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'


class SlackApiError < StandardError
end

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel(input, type)
    if type == 'id'
      channel = channels.find { |channel| channel.slack_id.downcase == input }
      return nil unless channel

      @selected = channel
      return channel
    elsif type == 'name'
      channel = channels.find { |channel| channel.name.downcase == input }
      return nil unless channel

      @selected = channel
      return channel
    else
      raise ArgumentError, 'Invalid search criteria'
    end
  end


  def select_user(input, type)
    if type == 'id'
      user = users.find { |user| user.slack_id.downcase == input }
      return nil unless user

      @selected = user
      return user
    elsif type == 'name'
      user = users.find { |user| user.name.downcase == input }
      return nil unless user

      @selected = user
      return user
    else
      raise ArgumentError, 'Invalid search criteria'
    end
  end
end