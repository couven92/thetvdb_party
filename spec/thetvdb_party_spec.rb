require 'rspec'

describe 'TheTvDbParty' do
  client = TheTvDbParty::Client.new(ENV["TVDB_API_KEY"])
  let(:search_series_records) { client.search "The Mentalist" }

  it 'should find search results' do
    # client = TheTvDbParty::Client.new(ENV["TVDB_API_KEY"])
    # let(:results) { client.search "The Mentalist" }
    expect(search_series_records).to_not be_nil
    expect(search_series_records).to_not be_empty
  end
end
