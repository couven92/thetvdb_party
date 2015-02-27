require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty' do
  it 'should find search results' do
    client = TheTvDbParty::Client.new(ENV["TVDB_API_KEY"])
    result_records = client.search "The Mentalist"
    result_names = result_records.map { |record| record.seriesname }
    expect(result_names).to include("The Mentalist")
  end

  it 'should find the Base Series Record for search results' do
    client = TheTvDbParty::Client.new(ENV["TVDB_API_KEY"])
    pending "No API key available, test cannot run. Configure .env file to include an api key." unless client.apikey
    client.search("The Mentalist").each do |result_record|
      expect(result_record).to be_a TheTvDbParty::SearchSeriesRecord
      base_series_record = result_record.get_base_series_record
      expect(base_series_record).to be_a TheTvDbParty::BaseSeriesRecord
      expect(base_series_record.seriesid).to eq result_record.seriesid
    end
  end
end
