
class Recipient
  attr_reader :slack_id, :name
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in the child class'
  end
end