# frozen_string_literal: true

class SlackApiError < StandardError
end

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end



end