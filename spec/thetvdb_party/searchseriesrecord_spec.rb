require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::SearchSeriesRecord' do

  it 'should have a client associated with it' do
    record = TheTvDbParty::SearchSeriesRecord.new TheTvDbParty::Client.new, { }
    expect(record.client).to be_a TheTvDbParty::Client
  end

  it 'should have a nil client, if constructed with nil' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { }
    expect(record.client).to be_nil
  end

  it 'should have a series id' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "seriesid" => "82459" }
    expect(record.seriesid).to be_a Fixnum
    expect(record.seriesid).to eq 82459
  end

  it 'should have a negative series id, if an invalid id is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "seriesid" => "INVALID_SERIESID" }
    expect(record.seriesid).to be_a Fixnum
    expect(record.seriesid).to be < 0
  end

  it 'should have a negative series id, if none is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, {  }
    expect(record.seriesid).to be_a Fixnum
    expect(record.seriesid).to be < 0
  end

  it 'should have a language' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "language" => "en" }
    expect(record.language).to be_a String
    expect(record.language).to eq "en"
  end

  it 'should have a nil language, if none is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { }
    expect(record.language).to be_nil
  end

  it 'should have a series name' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "SeriesName" => "The Mentalist" }
    expect(record.seriesname).to be_a String
    expect(record.seriesname).to eq "The Mentalist"
  end

  it 'should have a single element array for the aliases, if only one is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new(nil, { "AliasNames" => "Star Trek: The Original Series" })
    expect(record.aliasnames).to match_array(["Star Trek: The Original Series"])
  end

  it 'should have a multi element array for the aliases, if a pipe-delimited list is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new(nil, { "AliasNames" => "Star Trek: The Original Series|Star Trek: TOS" })
    expect(record.aliasnames).to match_array(["Star Trek: The Original Series", "Star Trek: TOS"])
  end

  it 'should have a multi element array for the aliases, if a pipe-surrounded list is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new(nil, { "AliasNames" => "|Star Trek: The Original Series|Star Trek: TOS|" })
    expect(record.aliasnames).to match_array(["Star Trek: The Original Series", "Star Trek: TOS"])
  end

  it 'should have an empty array for the aliases, if none is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new(nil, {  })
    expect(record.aliasnames).to be_empty
  end

  it 'should have a relative/full banner path' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "banner" => "graphical/82459-g4.jpg" }
    expect(record.bannerpath_relative).to be_a String
    expect(record.bannerpath_full).to be_a URI::Generic
    expect(record.bannerpath_relative).to eq "graphical/82459-g4.jpg"
    expect(record.bannerpath_full).to eq URI::join(TheTvDbParty::BASE_URL, 'banners/', "graphical/82459-g4.jpg")
  end

  it 'should have a nil relative/full bannerpath, if none is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { }
    expect(record.bannerpath_relative).to be_nil
    expect(record.bannerpath_full).to be_nil
  end

  it 'should have an overview' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "Overview" => "SAMPLE_OVERVIEW" }
    expect(record.overview).to be_a String
    expect(record.overview).to eq "SAMPLE_OVERVIEW"
  end

  it 'should have a first aired date' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "FirstAired" => "2008-09-23" }
    expect(record.firstaired).to be_a Date
    expect(record.firstaired).to eq Date.new(2008, 9, 23)
  end

  it 'should have a nil first aired date, id invalid specified' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "FirstAired" => "INVALID_FIRSTAIRED" }
    expect(record.firstaired).to be_nil
  end

  it 'should have a nil first aired date, if none specified' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, {  }
    expect(record.firstaired).to be_nil
  end

  it 'should have an IMDB id' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "IMDB_ID" => "tt1196946" }
    expect(record.imdb_id).to be_a String
    expect(record.imdb_id).to eq "tt1196946"
  end

  it 'should have a nil IMDB id, if none is specified' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, {  }
    expect(record.imdb_id).to be_nil
  end

  it 'should have a zap2it id' do
    record = TheTvDbParty::SearchSeriesRecord.new nil, { "zap2it_id" => "EP01058714" }
    expect(record.zap2it_id).to be_a String
    expect(record.zap2it_id).to eq "EP01058714"
  end

  it 'should have a network' do
    record = TheTvDbParty::SearchSeriesRecord.new(nil, {"Network" => "CBS"})
    expect(record.network).to be_a String
    expect(record.network).to eq "CBS"
  end

  it 'should have a nil network, if not specified' do
    record = TheTvDbParty::SearchSeriesRecord.new(nil, {})
    expect(record.network).to be_nil
  end

  it 'should not instantiate when created without hash values' do
    expect { TheTvDbParty::SearchSeriesRecord.new nil, nil }.to raise_error
  end
end
