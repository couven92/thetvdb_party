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
    pending "No API key available, test cannot run. Configure .env.yml file to include an api key." unless client.apikey
    client.search("The Mentalist").each do |result_record|
      expect(result_record).to be_a TheTvDbParty::SearchSeriesRecord
      base_series_record = result_record.get_base_series_record
      expect(base_series_record).to be_a TheTvDbParty::BaseSeriesRecord
      expect(base_series_record.seriesid).to eq result_record.seriesid
    end
  end

  it 'should find the Full Series Record for search results and this should include an episode list' do
    client = TheTvDbParty::Client.new(ENV["TVDB_API_KEY"])
    pending "No API key available, test cannot run. Configure .env.yml file to include an api key." unless client.apikey
    client.search("The Mentalist").each do |result_record|
      expect(result_record).to be_a TheTvDbParty::SearchSeriesRecord
      full_series_record = result_record.get_full_series_record
      expect(full_series_record).to be_a TheTvDbParty::FullSeriesRecord
      expect(full_series_record.seriesid).to eq result_record.seriesid
      expect(full_series_record.episodes.length).to be > 0
      full_series_record.episodes.each do |base_episode_record|
        expect(base_episode_record.seriesid).to eq full_series_record.seriesid
      end
    end
  end
end
