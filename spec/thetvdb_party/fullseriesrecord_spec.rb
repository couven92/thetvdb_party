require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::FullSeriesRecord' do

  it 'should have an empty episode list if no episodes are specified' do
    record = TheTvDbParty::FullSeriesRecord.new nil, { "Series" => {  } }
    expect(record.episodes).to be_an(Array)
    expect(record.episodes).to be_empty
  end

  it 'should have a single entry episode list, if only one Episode is specified' do
    record = TheTvDbParty::FullSeriesRecord.new nil, { "Series" => {  }, "Episode" => { } }
    expect(record.episodes).to be_an(Array)
    expect(record.episodes.length).to eq 1
    record.episodes.each { |episode_record| expect(episode_record).to be_a(TheTvDbParty::BaseEpisodeRecord) }
  end

  it 'should have multiple entries in the episode list, if more than one Episode is specified' do
    record = TheTvDbParty::FullSeriesRecord.new nil, { "Series" => {  }, "Episode" => [ { }, { } ] }
    expect(record.episodes).to be_an(Array)
    expect(record.episodes.length).to be > 1
    record.episodes.each { |episode_record| expect(episode_record).to be_a(TheTvDbParty::BaseEpisodeRecord) }
  end

  it 'should not instantiate when constructed with nil hash values' do
    expect { TheTvDbParty::FullSeriesRecord.new nil, nil }.to raise_error
  end

  it 'should not instantiate when constructed with a hash missing the Series tag' do
    expect { TheTvDbParty::FullSeriesRecord.new nil, { } }.to raise_error
  end
end
