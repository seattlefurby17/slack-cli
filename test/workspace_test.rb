# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/workspace'

describe 'Workspace class' do
  before do
    VCR.use_cassette('slack_workspace') do
      @workspace = Workspace.new
    end
  end

  describe 'Workspace initialization' do
    it 'can initialize correctly' do
      expect(@workspace.channels.length).must_equal 48
      expect(@workspace.users.length).must_equal 163
    end
  end

  it 'first channel' do
    first_channel = @workspace.channels.first
    expect(first_channel.name).must_equal 'general'
    expect(first_channel.topic).must_equal 'No topic set'
    expect(first_channel.member_count).must_equal 106
    expect(first_channel.slack_id).must_equal 'C0165N9BX3M'
  end
  it 'last channel' do
    last_channel = @workspace.channels.last
    expect(last_channel.name).must_equal 'test_channel_alice'
    expect(last_channel.topic).must_equal 'No topic set'
    expect(last_channel.member_count).must_equal 4
    expect(last_channel.slack_id).must_equal 'C01C8UKJVEW'
  end
  describe 'select_channel method' do
    it 'can find channel by id' do
      channel = @workspace.select_channel('C01ABK51G14'.downcase, 'slack_id')
      expect(channel.name).must_equal 'test-channel2'
    end

    it 'can find channel by name' do
      channel = @workspace.select_channel('test-channel2', 'name')
      expect(channel.slack_id).must_equal 'C01ABK51G14'
    end

    it 'can find user by id' do
      user = @workspace.select_user('U01CSBLGZPS'.downcase, 'slack_id')
      expect(user.name).must_equal 'richelle-bot'
    end

    it 'can find user by name' do
      user = @workspace.select_user('richelle-bot', 'name')
      expect(user.slack_id).must_equal 'U01CSBLGZPS'
    end

    it 'returns nil for invalid values' do
      expect(@workspace.select_user('non-existent', 'name')).must_be_nil
      expect(@workspace.select_user('non-existent', 'slack_id')).must_be_nil
      expect(@workspace.select_channel('non-existent', 'name')).must_be_nil
      expect(@workspace.select_channel('non-existent', 'slack_id')).must_be_nil
    end

    it 'raises an error for invalid search type' do
      expect { @workspace.select_channel('test', 'abc') }.must_raise ArgumentError
      expect { @workspace.select_user('test', 'abc') }.must_raise ArgumentError
    end
  end
  describe 'send_message method' do
    it 'has a send_message method' do
      expect(@workspace).must_respond_to :send_message
    end

    it 'can send a message to a selected channel by name' do
      VCR.use_cassette('slack_send_message') do
        @workspace = Workspace.new
        @workspace.select_channel('test-channel2', 'name')
        expect @workspace.send_message('I shot first').must_equal true
      end
    end

    it 'can send message to a selected channel by slack_id' do
      VCR.use_cassette('slack_send_message') do
        @workspace = Workspace.new
        @workspace.select_channel('C01ABK51G14', 'slack_id')
        expect @workspace.send_message('I shot first').must_equal true
      end
    end

    it 'can send a message to a selected user by name' do
      VCR.use_cassette('slack_send_message') do
        @workspace = Workspace.new
        @workspace.select_user('beatress', 'name')
        expect @workspace.send_message('I shot first').must_equal true
      end
    end
    it 'can send a message to a selected user by slack_id' do
      VCR.use_cassette('slack_send_message') do
        @workspace = Workspace.new
        @workspace.select_user('U017F099ZFX', 'slack_id')
        expect @workspace.send_message('I shot first').must_equal true
      end
    end

    it 'will raise an error if selected channel is invalid' do
      VCR.use_cassette('slack_send_message') do
          @workspace = Workspace.new
        invalid_channel = Channel.new(slack_id: '777', name: 'burger', topic: 'more burger', member_count: 1)
     
        expect { invalid_channel.send_message('Invalid channel') }.must_raise SlackApiError
        end
    end

    it 'will raise an error if selected user is invalid' do
      VCR.use_cassette('slack_send_message') do
        @workspace = Workspace.new
        invalid_user = User.new(slack_id: '777555', name: 'baby', real_name: 'real baby', status_text: 'crying', status_emoji: ':(')
        expect { invalid_user.send_message('Invalid user') }.must_raise SlackApiError
      end
    end
  end
end
