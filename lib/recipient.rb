require 'dotenv'
require 'httparty'

Dotenv.load

class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    sleep(1)
    if response.code != 200 || response['ok'] != true
      raise SlackApiError, 'Slack API call failed!'
    end

    return response
  end

  # These are just template methods to be implemented in User and Channel
  def details
    raise NotImplementedError, 'Implement me in the child class'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in the child class'
  end
end