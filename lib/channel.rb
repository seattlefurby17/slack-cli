
class Channel < Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    super(slack_id, name)
  end

  def details

  end

  def self.list_all
    # response['channels'].each do |channel|
    #   puts channel['name']
    end

  end


end