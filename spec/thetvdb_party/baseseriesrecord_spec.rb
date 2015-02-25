require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::BaseSeriesRecord' do
  it 'should have a client associated with it' do
    client = TheTvDbParty::Client.new
    record = TheTvDbParty::BaseSeriesRecord.new client, { }
    expect(record.client).to be_a(TheTvDbParty::Client)
  end

  it 'should have a nil client if constructed with nil' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.client).to be_nil
  end

  it 'should have an id' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "id" => "82459" })
    expect(record.seriesid).to be_a(Fixnum)
    expect(record.seriesid).to eq(82459)
  end

  it 'should have a negative id, if invalid specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "id" => "INVALID_ID" }
    expect(record.seriesid).to be_a(Fixnum)
    expect(record.seriesid).to be < 0
  end

  it 'should have a negative id, if not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.seriesid).to be_a(Fixnum)
    expect(record.seriesid).to be < 0
  end

  it 'should have a single element array for the actors, if only one name is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Actors" => "Simon Baker" })
    expect(record.actors).to match_array(["Simon Baker"])
  end

  it 'should have a multi element array for the actors, if a pipe-delimited list is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Actors" => "Simon Baker|Robin Tunney|Amanda Righetti|Owain Yeoman|Tim Kang|Emily Swallow|Rockmond Dunbar|Michael Gaston|Pruitt Taylor Vince|Aunjanue Ellis|Gregory Itzin|Terry Kinney|Joe Adler|Josie Loren" })
    expect(record.actors).to match_array(["Simon Baker", "Robin Tunney", "Amanda Righetti", "Owain Yeoman", "Tim Kang", "Emily Swallow", "Rockmond Dunbar", "Michael Gaston", "Pruitt Taylor Vince", "Aunjanue Ellis", "Gregory Itzin", "Terry Kinney", "Joe Adler", "Josie Loren"])
  end

  it 'should have a multi element array for the actors, if a pipe-surrounded list is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Actors" => "|Simon Baker|Robin Tunney|Amanda Righetti|Owain Yeoman|Tim Kang|Emily Swallow|Rockmond Dunbar|Michael Gaston|Pruitt Taylor Vince|Aunjanue Ellis|Gregory Itzin|Terry Kinney|Joe Adler|Josie Loren|" })
    expect(record.actors).to match_array(["Simon Baker", "Robin Tunney", "Amanda Righetti", "Owain Yeoman", "Tim Kang", "Emily Swallow", "Rockmond Dunbar", "Michael Gaston", "Pruitt Taylor Vince", "Aunjanue Ellis", "Gregory Itzin", "Terry Kinney", "Joe Adler", "Josie Loren"])
  end

  it 'should have an empty array for the actors, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {  })
    expect(record.actors).to be_empty
  end

  it 'should have the airs on day of week information' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "Airs_DayOfWeek" => "Wednesday" }
    expect(record.airs_dayofweek).to be_a(String)
    expect(record.airs_dayofweek).to eq("Wednesday")
  end

  it 'should have a nil airs day of week, if not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.airs_dayofweek).to be_nil
  end

  it 'should have an airing time' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "Airs_Time" => "8:00 PM" }
    expect(record.airs_time).to be_a(Time)
    reference_time = Time.new(2015, 1, 1, 20, 0, 0)
    expect(record.airs_time.hour).to eq(reference_time.hour)
    expect(record.airs_time.min).to eq(reference_time.min)
  end

  it 'should have a nil airing time, if invalid specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "Airs_Time" => "INVALID_AIRS_TIME" }
    expect(record.airs_time).to be_nil
  end

  it 'should have a nil airing time, if not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.airs_time).to be_nil
  end

  it 'should have a content rating' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "ContentRating" => "TV-14" }
    expect(record.contentrating).to be_a String
    expect(record.contentrating).to eq "TV-14"
  end

  it 'should have a nil content rating, if not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.contentrating).to be_nil
  end

  it 'should have a first aired date' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "FirstAired" => "2008-09-23" }
    expect(record.firstaired).to be_a Date
    expect(record.firstaired).to eq Date.new(2008, 9, 23)
  end

  it 'should have a nil first aired date, id invalid specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "FirstAired" => "INVALID_FIRSTAIRED" }
    expect(record.firstaired).to be_nil
  end

  it 'should have a nil first aired date, id none specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.firstaired).to be_nil
  end

  it 'should have a single element array for the genre, if only one is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Genre" => "Crime" })
    expect(record.genres).to match_array(["Crime"])
  end

  it 'should have a multi element array for the writer, if a pipe-delimited list is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Genre" => "Crime|Drama|Mystery" })
    expect(record.genres).to match_array(["Crime", "Drama", "Mystery"])
  end

  it 'should have a multi element array for the writer, if a pipe-surrounded list is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Genre" => "|Crime|Drama|Mystery|" })
    expect(record.genres).to match_array(["Crime", "Drama", "Mystery"])
  end

  it 'should have an empty array for writer, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {  })
    expect(record.genres).to be_empty
  end

  it 'should have an IMDB id' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "IMDB_ID" => "tt1196946" }
    expect(record.imdb_id).to be_a String
    expect(record.imdb_id).to eq "tt1196946"
  end

  it 'should have a nil IMDB id, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.imdb_id).to be_nil
  end

  it 'should have a language associated with the record' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {"Language" => "en"})
    expect(record.language).to be_a(String)
    expect(record.language).to eq("en")
  end

  it 'should have a nil language associated with the record, if not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {})
    expect(record.language).to be_nil
  end

  it 'should have a network' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {"Network" => "CBS"})
    expect(record.network).to be_a String
    expect(record.network).to eq "CBS"
  end

  it 'should have a nil network, if not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {})
    expect(record.network).to be_nil
  end

  it 'should have a network id' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "NetworkID" => "123456" }
    expect(record.networkid).to be_a Fixnum
    expect(record.networkid).to eq 123456
  end

  it 'should have a negative network id, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.networkid).to be_nil
  end

  it 'should have an overview' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "Overview" => "SAMPLE_OVERVIEW" }
    expect(record.overview).to be_a String
    expect(record.overview).to eq "SAMPLE_OVERVIEW"
  end

  it 'should have a rating' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Rating" => "6.6667" })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be >= 0.0
    expect(record.rating).to be 6.6667
  end

  it 'should have a zero rating, if invalid specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "Rating" => "INVALID_RATING" })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be 0.0
  end

  it 'should have a zero rating, if it is not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {  })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be 0.0
  end

  it 'should have a rating count' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "RatingCount" => "6" })
    expect(record.ratingcount).to be_an_instance_of(Fixnum)
    expect(record.ratingcount).to be >= 0
    expect(record.ratingcount).to eq(6)
  end

  it 'should have a zero rating count, if invalid specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, { "RatingCount" => "INVALID_RATINGCOUNT" })
    expect(record.ratingcount).to be_an_instance_of(Fixnum)
    expect(record.ratingcount).to be 0
  end

  it 'should have a zero rating count, if it is not specified' do
    record = TheTvDbParty::BaseSeriesRecord.new(nil, {  })
    expect(record.ratingcount).to be_an_instance_of(Fixnum)
    expect(record.ratingcount).to be 0
  end

  it 'should have runtime' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "Runtime" => "60" }
    expect(record.runtime).to be_a Fixnum
    expect(record.runtime).to eq 60
  end

  it 'should have a negative runtime, if invalid specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "Runtime" => "INVALID_RUNTIME" }
    expect(record.runtime).to be_a Fixnum
    expect(record.runtime).to be < 0
  end

  it 'should have a negative runtime, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.runtime).to be_a Fixnum
    expect(record.runtime).to be < 0
  end

  it 'should have a TV.com id' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "SeriesID" => "75200" }
    expect(record.tvcom_id).to be_a Fixnum
    expect(record.tvcom_id).to eq 75200
  end

  it 'should have a nil TV.com id, if none is spcified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.tvcom_id).to be_nil
  end

  it 'should have a series name' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "SeriesName" => "The Mentalist" }
    expect(record.seriesname).to be_a String
    expect(record.seriesname).to eq "The Mentalist"
  end

  it 'should have a nil series name, if none is spcified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.seriesname).to be_nil
  end

  it 'should have a status' do
    %w(Ended Continuing).each do |expected_valid_status|
      record = TheTvDbParty::BaseSeriesRecord.new nil, { "Status" => expected_valid_status }
      expect(record.status).to be_a String
      expect(record.status).to eq expected_valid_status
    end
  end

  it 'should have a nil status, if an invalid one is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "Status" => "INVALID_STATUS" }
    expect(record.status).to be_nil
  end

  it 'should have a nil status, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.status).to be_nil
  end

  it 'should have an added timestamp' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "added" => "2015-01-01 12:00:00" }
    expect(record.added).to be_a DateTime
    expect(record.added).to eq DateTime.new(2015, 1, 1, 12, 0, 0)
  end

  it 'should have a nil added timestamp, if an invalid time was specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "added" => "INVALID_ADDED" }
    expect(record.added).to be_nil
  end

  it 'should have a nil added timestamp, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.added).to be_nil
  end

  it 'should have an added by field' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "addedBy" => "123456" }
    expect(record.addedby).to be_a Fixnum
    expect(record.addedby).to eq 123456
  end

  it 'should have a nil added by field, if an invalid account is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "addedBy" => "INVALID_ADDEDBY" }
    expect(record.addedby).to be_nil
  end

  it 'should have a nil added by field, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.addedby).to be_nil
  end

  it 'should have a relative/full banner path' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "banner" => "graphical/82459-g4.jpg" }
    expect(record.bannerpath_relative).to be_a String
    expect(record.bannerpath_full).to be_a URI::Generic
    expect(record.bannerpath_relative).to eq "graphical/82459-g4.jpg"
    expect(record.bannerpath_full).to eq URI::join(TheTvDbParty::BASE_URL, 'banners/', "graphical/82459-g4.jpg")
  end

  it 'should have a nil relative/full bannerpath, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.bannerpath_relative).to be_nil
    expect(record.bannerpath_full).to be_nil
  end

  it 'should have a relative/full fanart path' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "fanart" => "fanart/original/82459-18.jpg" }
    expect(record.fanartpath_relative).to be_a String
    expect(record.fanartpath_full).to be_a URI::Generic
    expect(record.fanartpath_relative).to eq "fanart/original/82459-18.jpg"
    expect(record.fanartpath_full).to eq URI::join(TheTvDbParty::BASE_URL, 'banners/', "fanart/original/82459-18.jpg")
  end

  it 'should have a nil relative/full fanart, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.fanartpath_relative).to be_nil
    expect(record.fanartpath_full).to be_nil
  end

  it 'should have a last updated timestamp' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "lastupdated" => "1424815167" }
    expect(record.lastupdated).to be_a DateTime
    expect(record.lastupdated).to eq Time.at(1424815167).to_datetime
  end

  it 'should have a nil last updated timestamp, if an invalid time is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "lastupdated" => "INVALID_LASTUPDATED" }
    expect(record.lastupdated).to be_nil
  end

  it 'should have a nil last updated timestamp, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, {  }
    expect(record.lastupdated).to be_nil
  end

  it 'should have a relative/full poster path' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "poster" => "posters/82459-6.jpg" }
    expect(record.posterpath_relative).to be_a String
    expect(record.posterpath_full).to be_a URI::Generic
    expect(record.posterpath_relative).to eq "posters/82459-6.jpg"
    expect(record.posterpath_full).to eq URI::join(TheTvDbParty::BASE_URL, 'banners/', "posters/82459-6.jpg")
  end

  it 'should have a nil relative/full poster, if none is specified' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { }
    expect(record.posterpath_relative).to be_nil
    expect(record.posterpath_full).to be_nil
  end

  it 'should have a zap2it id' do
    record = TheTvDbParty::BaseSeriesRecord.new nil, { "zap2it_id" => "EP01058714" }
    expect(record.zap2it_id).to be_a String
    expect(record.zap2it_id).to eq "EP01058714"
  end

  it 'should not instantiate when created without hash values' do
    expect { TheTvDbParty::BaseSeriesRecord.new(nil, nil) }.to raise_error
  end
end
