require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::AllSeriesInformation' do

  before(:each) do
    @client = TheTvDbParty::Client.new(ENV["TVDB_API_KEY"])
    results = @client.search('The Big Bang Theory')
    @all_series_info = @client.get_series_all(results.first.seriesid)
    expect(@all_series_info).to_not be_nil
  end


  it 'should have a valid client' do
    expect(@all_series_info.client).to be_an_instance_of(TheTvDbParty::Client)
  end

  it 'should contain a series class' do
    expect(@all_series_info.full_series_record).to be_an_instance_of(TheTvDbParty::FullSeriesRecord)
  end

  it 'should contain a list of banner classes' do
    expect(@all_series_info.banners).to  be_an_instance_of(Array)
    @all_series_info.banners.each do |b|
      expect(b).to be_an_instance_of(TheTvDbParty::Banner)
    end
  end
end