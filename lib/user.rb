
class User < Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    super(slack_id, name)
  end

end