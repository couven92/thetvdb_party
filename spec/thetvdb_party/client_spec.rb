require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::Client' do

  it 'should have an api key' do
    client = TheTvDbParty::Client.new "123456789"
    expect(client.apikey).to be_a String
  end

  it 'should have a nil api key, if none is spcified' do
    client = TheTvDbParty::Client.new
    expect(client.apikey).to be_nil
  end

  it 'should have a language associated with it' do
    client = TheTvDbParty::Client.new do |c|
      c.language = "en"
    end
    expect(client.language).to be_a String
    expect(client.language).to eq "en"
  end

  it 'should have a nil language, if none is specified' do
    client = TheTvDbParty::Client.new
    expect(client.language).to be_nil
  end
end
