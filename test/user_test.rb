# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/recipient'
require_relative '../lib/user'

describe 'User class' do
  before do
    @slack_id = '007'
    @name = 'James Bond'
    @real_name = 'Unknown'
    @status_text = 'Spying...'
    @status_emoji = ':sleuth_or_spy:'
    @user = User.new(slack_id: @slack_id,
                     name: @name,
                     real_name: @real_name,
                     status_text: @status_text,
                     status_emoji: @status_emoji)
  end

  describe 'user initialization' do
    it 'can initialize correctly' do
      expect(@user.slack_id).must_equal @slack_id
      expect(@user.name).must_equal @name
      expect(@user.real_name).must_equal @real_name
      expect(@user.status_text).must_equal @status_text
      expect(@user.status_emoji).must_equal @status_emoji
    end
  end

  describe 'get_details method' do
    it 'return the proper details ' do
      expect(@user.get_details).must_equal "Slack ID: #{@slack_id}\nName: #{@name}\n"\
      "Real Name: #{@real_name}\nStatus Text: #{@status_text}\nStatus Emoji: #{@status_emoji}"
    end
  end

  describe 'list_all method' do
    before do
      VCR.use_cassette('slack_user_list') do
        @user_list = User.list_all
      end
    end

    it 'should return an instance of user class' do
      @user_list.each do |user|
        expect(user).must_be_instance_of User
      end
    end

    it 'should return an array of users' do
      expect(@user_list).must_be_kind_of Array
    end

    it 'should return the number of users' do
      expect(@user_list.length).must_equal 162
    end
  end
end