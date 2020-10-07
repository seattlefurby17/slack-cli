class Channel < Recipient
  attr_reader :slack_id, :name, :topic, :member_count

  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def get_details
    puts "Slack ID: #{slack_id}"
    puts "Name: #{name}"
    puts "Topic: #{topic}"
    puts "Member Count: #{member_count}"
  end

  def self.list_all
    url = "https://slack.com/api/conversations.list"
    params = { token: ENV['SLACK_TOKEN'] }
    response = Channel.get(url, params)
    channel_list = []

    response['channels'].each do |channel|
      topic = channel['topic']['value']
      topic = 'No topic set' if topic == ''
      channel_list << Channel.new(
          slack_id: channel['id'],
          name: channel['name'],
          topic: topic,
          member_count: channel['num_members']
      )
    end
    return channel_list
  end

end

