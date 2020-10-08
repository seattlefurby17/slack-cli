class User < Recipient
  attr_reader :slack_id, :name, :real_name, :status_text, :status_emoji

  def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def get_details
    return "Slack ID: #{slack_id}\n" + "Name: #{name}\n" + "Real Name: #{real_name}\n" + "Status Text: #{status_text}\n" + "Status Emoji: #{status_emoji}"
  end

  def self.list_all
    url = 'https://slack.com/api/users.list'
    params = { token: ENV['SLACK_TOKEN'] }
    begin
      response = Channel.get(url, params)
    rescue SlackApiError => exception
      puts "Unsuccessful request, #{exception.message}. Please try again"
      exit
    end
    user_list = []

    response['members'].each do |user|
      status_text = user['profile']['status_text']
      status_text = 'No status' if status_text == ''
      status_emoji = user['profile']['status_emoji']
      status_emoji = 'No emoji' if status_emoji == ''

      user_list << User.new(
        slack_id: user['id'],
        name: user['name'],
        real_name: user['real_name'],
        status_text: status_text,
        status_emoji: status_emoji
      )
    end
    return user_list

  end
end