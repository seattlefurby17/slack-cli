
require_relative 'test_helper'
require_relative '../lib/workspace'

describe "workspace" do
  before do
    VCR.use_cassette('slack_workspace') do
      @workspace = Workspace.new
    end
  end

  it 'can initialize correctly' do
    expect(@workspace.channels.length).must_equal 47
    expect(@workspace.users.length).must_equal 162
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
end
