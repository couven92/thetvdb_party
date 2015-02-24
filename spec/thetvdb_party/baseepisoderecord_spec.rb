require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::BaseEpisodeRecord' do
  it 'should have a client associated with it' do
    client = TheTvDbParty::Client.new(nil)
    record = TheTvDbParty::BaseEpisodeRecord.new(client, {  })
    expect(record.client).to be_an_instance_of(TheTvDbParty::Client)
  end

  it 'should have a nil client if constructed with nil' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.client).to be_nil
  end

  it 'should have an id' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "id" => "533011" })
    expect(record.id).to be_an_instance_of(Fixnum)
    expect(record.id).to eq(533011)
  end

  it 'should have a negative id, if invalid id specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "id" => "INVALID_ID" })
    expect(record.id).to be_an_instance_of(Fixnum)
    expect(record.id).to be < 0
  end

  it 'should have a negative id, if id not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.id).to be_an_instance_of(Fixnum)
    expect(record.id).to be < 0
  end

  it 'should have a combined episode number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Combined_episodenumber" => "5.2" })
    expect(record.combined_episodenumber).to be_an_instance_of(Float)
    expect(record.combined_episodenumber).to eq(5.2)
  end

  it 'should have a negative combined episode number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Combined_episodenumber" => "INVALID_COMBINED_EPISODE_NUMBER" })
    expect(record.combined_episodenumber).to be_an_instance_of(Float)
    expect(record.combined_episodenumber).to be < 0
  end

  it 'should have a negative combined episode number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.combined_episodenumber).to be_an_instance_of(Float)
    expect(record.combined_episodenumber).to be < 0
  end

  it 'should have a combined season number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Combined_season" => "5" })
    expect(record.combined_season).to be_an_instance_of(Fixnum)
    expect(record.combined_season).to eq(5)
  end

  it 'should have a negative combined episode number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Combined_season" => "INVALID_COMBINED_SEASON" })
    expect(record.combined_season).to be_an_instance_of(Fixnum)
    expect(record.combined_season).to be < 0
  end

  it 'should have a negative combined episode number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.combined_season).to be_an_instance_of(Fixnum)
    expect(record.combined_season).to be < 0
  end

  it 'should have a DVD chapter field' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "DVD_chapter" => "5" })
    expect(record.dvd_chapter).to be_an_instance_of(String)
    expect(record.dvd_chapter).to eq("5")
  end

  it 'should have a nil DVD chapter field, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.dvd_chapter).to be_nil
  end

  it 'should have a DVD disc field' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "DVD_discid" => "5" })
    expect(record.dvd_discid).to be_an_instance_of(String)
    expect(record.dvd_discid).to eq("5")
  end

  it 'should have a nil DVD disc field, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.dvd_chapter).to be_nil
  end

  it 'should have a DVD episode number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "DVD_episodenumber" => "1.2" })
    expect(record.dvd_episodenumber).to be_an_instance_of(Float)
    expect(record.dvd_episodenumber).to eq(1.2)
  end

  it 'should have a negative DVD episode number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "DVD_episodenumber" => "INVALID_DVD_EPISODENUMBER" })
    expect(record.dvd_episodenumber).to be_an_instance_of(Float)
    expect(record.dvd_episodenumber).to be < 0
  end

  it 'should have a negative DVD episode number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.dvd_episodenumber).to be_an_instance_of(Float)
    expect(record.dvd_episodenumber).to be < 0
  end

  it 'should have a DVD season number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "DVD_season" => "1" })
    expect(record.dvd_episodenumber).to be_an_instance_of(Fixnum)
    expect(record.dvd_episodenumber).to eq(1.2)
  end

  it 'should have a negative DVD season number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "DVD_season" => "INVALID_DVD_SEASON" })
    expect(record.dvd_episodenumber).to be_an_instance_of(Fixnum)
    expect(record.dvd_episodenumber).to be < 0
  end

  it 'should have a negative DVD season number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.dvd_episodenumber).to be_an_instance_of(Fixnum)
    expect(record.dvd_episodenumber).to be < 0
  end

  it 'should have a single element array for the director, if only one name is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Director" => "Graeme Harper" })
    expect(record.director).to match_array(["Graeme Harper"])
  end

  it 'should have a multi element array for the director, if a pipe-delimited list is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Director" => "Bruno Heller|Tom Szentgyorgyi|Jordan Harper" })
    expect(record.director).to match_array(["Bruno Heller", "Tom Szentgyorgyi", "Jordan Harper"])
  end

  it 'should have a multi element array for the director, if a pipe-surrounded list is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Director" => "|Bruno Heller|Tom Szentgyorgyi|Jordan Harper|" })
    expect(record.director).to match_array(["Bruno Heller", "Tom Szentgyorgyi", "Jordan Harper"])
  end

  it 'should have an empty array for director, if none is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.director).to be_empty
  end

  it 'should not instantiate when created without hash values' do
    expect { TheTvDbParty::BaseEpisodeRecord.new(nil, nil) }.to raise_error
  end
end
