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
      expect(@workspace.channels.length).must_equal 47
      expect(@workspace.users.length).must_equal 162
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
    expect(last_channel.name).must_equal 'testchannel-liroulirou'
    expect(last_channel.topic).must_equal 'No topic set'
    expect(last_channel.member_count).must_equal 1
    expect(last_channel.slack_id).must_equal 'C01BXHNFPHT'
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
  
end
