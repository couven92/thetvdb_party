require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::AllSeriesInformation' do

  # before(:each) do
  #   @client = TheTvDbParty::Client.new('5CB46CA60629B0DD')
    # results = @client.search('The Big Bang Theory')
  #   @single_show = @client.get_series_all(results.first.seriesid)
  # end


  it 'should have a client in' do
    client = TheTvDbParty::Client.new(' ')
    all_series_info = TheTvDbParty::AllSeriesInformation.new(client, ' ')
    expect(all_series_info.client).to be_an_instance_of(TheTvDbParty::Client)
  end

  it 'should contain a series class' do
    client = TheTvDbParty::Client.new('5CB46CA60629B0DD')
    results = client.search('The Big Bang Theory')
    all_series_info = client.get_series_all(results.first.seriesid)
    expect(all_series_info.series).to be_an_instance_of(TheTvDbParty::BaseSeriesRecord)
  end

end