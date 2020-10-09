# frozen_string_literal: true

require 'dotenv'
require 'httparty'

Dotenv.load

BASE_URL =	'https://slack.com/api'
API_KEY = ENV['SLACK_TOKEN']

class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    sleep(1)
    if response.code != 200
      raise SlackApiError, 'Slack API call failed!'
    elsif response['ok'] != true
      raise SlackApiError, (response['error']).to_s
    end

    response
  end

  def send_message(message)
    response = HTTParty.post(
      "#{BASE_URL}/chat.postMessage",
      body: {
        token: API_KEY,
        text: message,
        channel: self.name
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )

    unless response.code == 200 && response.parsed_response['ok']
      raise SlackApiError, "Error when posting #{message} to #{self.name}, error: #{response.parsed_response['error']}"
    end

    return true
  end

  # These are just template methods to be implemented in User and Channel
  def details
    raise NotImplementedError, 'Implement me in the child class'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in the child class'
  end
end
