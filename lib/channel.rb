
class Channel < Recipient
  attr_reader :slack_id, :name, :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    puts "Slack ID: #{slack_id}"
    puts "Name: #{name}"
    puts "Topic: #{topic}"
    puts "Member Count: #{member_count}"
  end

  def self.list_all
<<<<<<< HEAD

=======
    # response['channels'].each do |channel|
    #   puts channel['name']
    # return [channel1, channel2, channel3, channel4]
  end
   
  # @channels = Channel.list_all # returns array of channels # Class method
  # @channels.each do |channel|
  #   puts channel.details # Instance method
  # end
>>>>>>> d9d56f619a332bd97d46f3ac2856f9436b39e3f6

  def details
    puts @slack_id
    puts @name
    puts @topic
    puts @member_count
  end

end

