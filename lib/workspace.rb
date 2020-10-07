# frozen_string_literal: true
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'


class SlackApiError < StandardError
end

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end



end