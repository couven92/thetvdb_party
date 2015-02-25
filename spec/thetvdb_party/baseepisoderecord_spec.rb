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
    expect(record.dvd_season).to be_an_instance_of(Fixnum)
    expect(record.dvd_season).to eq(1.2)
  end

  it 'should have a negative DVD season number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "DVD_season" => "INVALID_DVD_SEASON" })
    expect(record.dvd_season).to be_an_instance_of(Fixnum)
    expect(record.dvd_season).to be < 0
  end

  it 'should have a negative DVD season number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.dvd_season).to be_an_instance_of(Fixnum)
    expect(record.dvd_season).to be < 0
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

  it 'should have a episode image flag' do
    (1..6).to_a.each do |expected_valid_epimgflag|
      record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "EpImgFlag" => expected_valid_epimgflag.to_s })
      expect(record.epimgflag).to be_an_instance_of(Fixnum)
      expect(record.epimgflag).to eq(expected_valid_epimgflag)
    end
  end

  it 'should have a zero episode image flag, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "EpImgFlag" => "INVALID_EPIMGFLAG" })
    expect(record.epimgflag).to be_an_instance_of(Fixnum)
    expect(record.epimgflag).to eq(0)
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "EpImgFlag" => "9" })
    expect(record.epimgflag).to be_an_instance_of(Fixnum)
    expect(record.epimgflag).to eq(0)
  end

  it 'should have a zero episode image flag, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.epimgflag).to be_an_instance_of(Fixnum)
    expect(record.epimgflag).to eq(0)
  end

  it 'should have an episode name' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "EpisodeName" => "White Orchids" })
    expect(record.episodename).to be_an_instance_of(String)
    expect(record.episodename).to eq("White Orchids")
  end

  it 'should have a nil episode name, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.episodename).to be_nil
  end

  it 'should have an episode number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "EpisodeNumber" => "1" })
    expect(record.episodenumber).to be_an_instance_of(Fixnum)
    expect(record.episodenumber).to eq(1)
  end

  it 'should have a negative episode number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "EpisodeNumber" => "INVALID_EPISODENUMBER" })
    expect(record.episodenumber).to be_an_instance_of(Fixnum)
    expect(record.episodenumber).to be < 0
  end

  it 'should have a negative episode number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.episodenumber).to be_an_instance_of(Fixnum)
    expect(record.episodenumber).to be < 0
  end

  it 'should have a first aired date' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "FirstAired" => "2009-11-15" })
    expect(record.firstaired).to be_an_instance_of(Date)
    expect(record.firstaired).to eq(Date.new(2009, 11, 15))
  end

  it 'should have a nil first aired date, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "FirstAired" => "INVALID_FIRSTAIRED" })
    expect(record.firstaired).to be_nil
  end

  it 'should have a nil first aired date, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.firstaired).to be_nil
  end

  it 'should have a single element array for the guest stars, if only one name is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "GuestStars" => "Lindsay Duncan" })
    expect(record.gueststars).to match_array(["Lindsay Duncan"])
  end

  it 'should have a multi element array for the guest stars, if a pipe-delimited list is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "GuestStars" => "Lindsay Duncan|Peter O'Brien|Sharon Duncan Brewster" })
    expect(record.gueststars).to match_array(["Lindsay Duncan", "Peter O'Brien", "Sharon Duncan Brewster"])
  end

  it 'should have a multi element array for the guest stars, if a pipe-surrounded list is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "GuestStars" => "|Lindsay Duncan|Peter O'Brien|Sharon Duncan Brewster|" })
    expect(record.gueststars).to match_array(["Lindsay Duncan", "Peter O'Brien", "Sharon Duncan Brewster"])
  end

  it 'should have an empty array for guest stars, if none is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.gueststars).to be_empty
  end

  it 'should have an IMDB id' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"IMDB_ID" => "abcd1234"})
    expect(record.imdb_id).to be_an_instance_of(String)
    expect(record.imdb_id).to eq("abcd1234")
  end

  it 'should have a nil IMDB id, if none specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.imdb_id).to be_nil
  end

  it 'should have a language associated with the record' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"Language" => "en"})
    expect(record.language).to be_a(String)
    expect(record.language).to eq("en")
  end

  it 'should have a nil language associated with the record, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {})
    expect(record.language).to be_nil
  end

  it 'should have an overview' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"Overview" => "Location: Bowie Base One, Mars Date: 21st November 2059 Enemies: The Flood The Doctor..."})
    expect(record.overview).to be_a(String)
    expect(record.overview).to eq("Location: Bowie Base One, Mars Date: 21st November 2059 Enemies: The Flood The Doctor...")
  end

  it 'should have a nil overview, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.overview).to be_nil
  end

  it 'should have an production code' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"ProductionCode" => "abcd1234"})
    expect(record.productioncode).to be_an_instance_of(String)
    expect(record.productioncode).to eq("abcd1234")
  end

  it 'should have a nil production code, if none specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.productioncode).to be_nil
  end

  it 'should have a rating' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Rating" => "6.6667" })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be >= 0.0
    expect(record.rating).to be 6.6667
  end

  it 'should have a zero rating, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Rating" => "INVALID_RATING" })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be 0.0
  end

  it 'should have a zero rating, if it is not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be 0.0
  end

  it 'should have a rating count' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "RatingCount" => "6" })
    expect(record.ratingcount).to be_an_instance_of(Fixnum)
    expect(record.ratingcount).to be >= 0
    expect(record.ratingcount).to eq(6)
  end

  it 'should have a zero rating count, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "RatingCount" => "INVALID_RATINGCOUNT" })
    expect(record.ratingcount).to be_an_instance_of(Fixnum)
    expect(record.ratingcount).to be 0
  end

  it 'should have a zero rating count, if it is not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.ratingcount).to be_an_instance_of(Fixnum)
    expect(record.ratingcount).to be 0
  end

  it 'should have an season number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "SeasonNumber" => "1" })
    expect(record.seasonnumber).to be_an_instance_of(Fixnum)
    expect(record.seasonnumber).to eq(1)
  end

  it 'should have a negative season number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "SeasonNumber" => "INVALID_SEASONNUMBER" })
    expect(record.seasonnumber).to be_an_instance_of(Fixnum)
    expect(record.seasonnumber).to be < 0
  end

  it 'should have a negative season number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.seasonnumber).to be_an_instance_of(Fixnum)
    expect(record.seasonnumber).to be < 0
  end

  it 'should have a single element array for the writer, if only one name is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Writer" => "Russell T Davies" })
    expect(record.writer).to match_array(["Russell T Davies"])
  end

  it 'should have a multi element array for the writer, if a pipe-delimited list is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Writer" => "Russell T Davies|Phil Ford" })
    expect(record.writer).to match_array(["Russell T Davies", "Phil Ford"])
  end

  it 'should have a multi element array for the writer, if a pipe-surrounded list is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "Writer" => "|Russell T Davies|Phil Ford|" })
    expect(record.writer).to match_array(["Russell T Davies", "Phil Ford"])
  end

  it 'should have an empty array for writer, if none is specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.writer).to be_empty
  end

  it 'should have an absolute number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"absolute_number" => "151"})
    expect(record.absolute_number).to be_a(Fixnum)
    expect(record.absolute_number).to eq(151)
  end

  it 'should have a negative absolute number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"absolute_number" => "INVALID_ABSOLUTENUMBER"})
    expect(record.absolute_number).to be_a(Fixnum)
    expect(record.absolute_number).to be < 0
  end

  it 'should have a negative absolute number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.absolute_number).to be_a(Fixnum)
    expect(record.absolute_number).to be < 0
  end

  it 'should have an airs after season number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"airsafter_season" => "2"})
    expect(record.airsafter_season).to be_a(Fixnum)
    expect(record.airsafter_season).to eq(2)
  end

  it 'should have a negative airs after season number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"airsafter_season" => "INVALID_AIRSAFTER_SEASON"})
    expect(record.airsafter_season).to be_a(Fixnum)
    expect(record.airsafter_season).to be < 0
  end

  it 'should have a negative airs after season number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.airsafter_season).to be_a(Fixnum)
    expect(record.airsafter_season).to be < 0
  end

  it 'should have an airs before episode number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"airsbefore_episode" => "2"})
    expect(record.airsbefore_episode).to be_a(Fixnum)
    expect(record.airsbefore_episode).to eq(2)
  end

  it 'should have a negative airs before episode number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"airsbefore_episode" => "INVALID_AIRSBEFORE_EPISODE"})
    expect(record.airsbefore_episode).to be_a(Fixnum)
    expect(record.airsbefore_episode).to be < 0
  end

  it 'should have a negative airs before episode number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.airsbefore_episode).to be_a(Fixnum)
    expect(record.airsbefore_episode).to be < 0
  end

  it 'should have an airs before season number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"airsbefore_season" => "2"})
    expect(record.airsbefore_season).to be_a(Fixnum)
    expect(record.airsbefore_season).to eq(2)
  end

  it 'should have a negative airs before season number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"airsbefore_season" => "INVALID_AIRSBEFORE_SEASON"})
    expect(record.airsbefore_season).to be_a(Fixnum)
    expect(record.airsbefore_season).to be < 0
  end

  it 'should have a negative airs before season number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.airsbefore_season).to be_a(Fixnum)
    expect(record.airsbefore_season).to be < 0
  end

  it 'should have a relative/full episode image path' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"filename" => "episodes/82459/5038185.jpg"})
    expect(record.imagepath_relative).to be_a(String)
    expect(record.imagepath_full).to be_a(URI::Generic)
    expect(record.imagepath_relative).to eq("episodes/82459/5038185.jpg")
    expect(record.imagepath_full).to eq(URI::join(TheTvDbParty::BASE_URL, 'banners/', "episodes/82459/5038185.jpg"))
  end

  it 'should have a nil relative/full episode image path, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.imagepath_relative).to be_nil
    expect(record.imagepath_full).to be_nil
  end

  it 'should have a last updated timestamp' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "lastupdated" => "1424691313" })
    expect(record.lastupdated).to be_a(DateTime)
    expect(record.lastupdated).to eq(Time.at(1424691313).to_datetime)
  end

  it 'should have a nil last updated timestamp, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "lastupdated" => "INVALID_LASTUPDATED" })
    expect(record.lastupdated).to be_nil
  end

  it 'should have a nil last updated timestamp, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.lastupdated).to be_nil
  end

  it 'should have a season number' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"seasonid" => "2"})
    expect(record.seasonid).to be_a(Fixnum)
    expect(record.seasonid).to eq(2)
  end

  it 'should have a negative season number, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"seasonid" => "INVALID_SEASONID"})
    expect(record.seasonid).to be_a(Fixnum)
    expect(record.seasonid).to be < 0
  end

  it 'should have a negative airs before season number, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.seasonid).to be_a(Fixnum)
    expect(record.seasonid).to be < 0
  end

  it 'should have a series id' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"seriesid" => "82459"})
    expect(record.seriesid).to be_a(Fixnum)
    expect(record.seriesid).to eq(82459)
  end

  it 'should have a negative series id, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {"seriesid" => "INVALID_SERIESID"})
    expect(record.seriesid).to be_a(Fixnum)
    expect(record.seriesid).to be < 0
  end

  it 'should have a negative series id, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
    expect(record.seriesid).to be_a(Fixnum)
    expect(record.seriesid).to be < 0
  end

  it 'should have a thumbnail added date' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "thumb_added" => "2015-02-11 09:28:28" })
    expect(record.thumb_added).to be_a(DateTime)
    expect(record.thumb_added).to eq(DateTime.new(2015, 02, 11, 9, 28, 28))
  end

  it 'should have a nil thumbnail added date, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "thumb_added" => "INVALID_THUMB_ADDED" })
    expect(record.thumb_added).to be_nil
  end

  it 'should have a nil thumbnail added date, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.thumb_added).to be_nil
  end

  it 'should have thumbnail height field' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "thumb_height" => "225" })
    expect(record.thumb_height).to be_a(Fixnum)
    expect(record.thumb_height).to eq(225)
  end

  it 'should have a zero thumbnail height, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "thumb_width" => "INVALID_THUMB_HEIGHT" })
    expect(record.thumb_height).to be_a(Fixnum)
    expect(record.thumb_height).to eq(0)
  end

  it 'should have a zero thumbnail height, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.thumb_height).to be_a(Fixnum)
    expect(record.thumb_height).to eq(0)
  end

  it 'should have thumbnail width field' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "thumb_width" => "400" })
    expect(record.thumb_width).to be_a(Fixnum)
    expect(record.thumb_width).to eq(400)
  end

  it 'should have a zero thumbnail width, if invalid specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, { "thumb_width" => "INVALID_THUMB_WIDTH" })
    expect(record.thumb_width).to be_a(Fixnum)
    expect(record.thumb_width).to eq(0)
  end

  it 'should have a zero thumbnail width, if not specified' do
    record = TheTvDbParty::BaseEpisodeRecord.new(nil, {  })
    expect(record.thumb_width).to be_a(Fixnum)
    expect(record.thumb_width).to eq(0)
  end

  it 'should not instantiate when created without hash values' do
    expect { TheTvDbParty::BaseEpisodeRecord.new(nil, nil) }.to raise_error
  end
end
