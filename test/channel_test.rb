# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/recipient'
require_relative '../lib/channel'

describe 'Channel class' do
  before do
    @channel = Channel.new(slack_id: '007', name: 'James Bond', topic: 'Spy business', member_count: 101)
  end

  describe 'Channel initialization' do
    it 'can initialize correctly' do
      expect(@channel.slack_id).must_equal '007'
      expect(@channel.name).must_equal 'James Bond'
      expect(@channel.topic).must_equal 'Spy business'
      expect(@channel.member_count).must_equal 101
    end
  end

  describe 'get_details method' do
    it 'return the proper details ' do
      expect(@channel.get_details).must_equal "Slack ID: #{@channel.slack_id}\n"\
      + "Name: #{@channel.name}\n" + "Topic: #{@channel.topic}\n"\
      + "Member Count: #{@channel.member_count}"
    end
  end
  describe 'list_all method' do
    before do
      VCR.use_cassette('slack_channel_list') do
        @channel_list = Channel.list_all
      end
    end

    it 'should return an instance of channel class' do
      @channel_list.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
    end

    it 'should return an array of channels' do
      expect(@channel_list).must_be_kind_of Array
    end

    it 'should return the number of channels' do
      expect(@channel_list.length).must_equal 48
    end
  end
end
