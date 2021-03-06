require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::Banner' do
  it 'should have a client associated with it' do
    client = TheTvDbParty::Client.new(nil)
    record = TheTvDbParty::Banner.new(client, { })
    expect(record.client).to be_an_instance_of(TheTvDbParty::Client)
  end

  it 'should have a nil client if constructed with nil' do
    record = TheTvDbParty::Banner.new(nil, { })
    expect(record.client).to be_nil
  end

  it 'should have an ignored id field' do
    record = TheTvDbParty::Banner.new(nil, { "id" => "14820" })
    expect(record.id).to be_an_instance_of(String)
    expect(record.id).to eq("14820")
  end

  it 'should have a nil id, if not specified' do
    record = TheTvDbParty::Banner.new(nil, {})
    expect(record.id).to be_nil
  end

  it 'should have a relative/full banner path' do
    record = TheTvDbParty::Banner.new(nil, { "BannerPath" => "text/80348.jpg" })
    expect(record.banner_path_relative).to be_an_instance_of(String)
    expect(record.banner_path_full).to be_a(URI::Generic)
    expect(record.banner_path_relative).to eq("text/80348.jpg")
    expect(record.banner_path_full).to eq(URI::join(TheTvDbParty::BASE_URL, 'banners/', "text/80348.jpg"))
  end

  it 'should have a nil relative/full banner path, if not specified' do
    record = TheTvDbParty::Banner.new(nil, {})
    expect(record.banner_path_relative).to be_nil
    expect(record.banner_path_full).to be_nil
  end

  it 'should have a relative/full thumbnail path' do
    record = TheTvDbParty::Banner.new(nil, { "ThumbnailPath" => "_cache/fanart/original/80348-49.jpg" })
    expect(record.thumbnail_path_relative).to be_an_instance_of(String)
    expect(record.thumbnail_path_full).to be_a(URI::Generic)
    expect(record.thumbnail_path_relative).to eq("_cache/fanart/original/80348-49.jpg")
    expect(record.thumbnail_path_full).to eq(URI::join(TheTvDbParty::BASE_URL, 'banners/', "_cache/fanart/original/80348-49.jpg"))
  end

  it 'should have a nil relative/full thumbnail path, if not specified' do
    record = TheTvDbParty::Banner.new(nil, {})
    expect(record.thumbnail_path_relative).to be_nil
    expect(record.thumbnail_path_full).to be_nil
  end

  it 'should have a relative/full vignette path' do
    record = TheTvDbParty::Banner.new(nil, { "VignettePath" => "fanart/vignette/80348-49.jpg" })
    expect(record.vignette_path_relative).to be_an_instance_of(String)
    expect(record.vignette_path_full).to be_a(URI::Generic)
    expect(record.vignette_path_relative).to eq("fanart/vignette/80348-49.jpg")
    expect(record.vignette_path_full).to eq(URI::join(TheTvDbParty::BASE_URL, 'banners/', "fanart/vignette/80348-49.jpg"))
  end

  it 'should have a nil relative/full vignette path, if not specified' do
    record = TheTvDbParty::Banner.new(nil, {})
    expect(record.vignette_path_relative).to be_nil
    expect(record.vignette_path_full).to be_nil
  end

  it 'should have a banner type' do
    [ "poster", "fanart", "series", "season" ].each do |expected_valid_bannertype|
      record = TheTvDbParty::Banner.new(nil, { "BannerType" => expected_valid_bannertype })
      expect(record.banner_type).to be_an_instance_of(String)
      expect(record.banner_type).to eq(expected_valid_bannertype)
    end
  end

  it 'should have a nil banner type, if specified is invalid' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType" => "INVALID_BANNERTYPE_STRING" })
    expect(record.banner_type).to be_nil
  end

  it 'should have a nil banner type, if not specified' do
    record = TheTvDbParty::Banner.new(nil, {})
    expect(record.banner_type).to be_nil
  end

  it 'should have a secondary banner type' do
    {
        "poster" => [ "680x1000" ],
        "fanart" => [ "1280x720", "1920x1080" ],
        "series" => [ "text", "graphical", "blank" ],
        "season" => [ "season", "seasonwide" ]
    }.each do |expected_valid_bannertype, expected_valid_bannerytype2s|
      expected_valid_bannerytype2s.each do |expected_valid_bannerytype2|
        record = TheTvDbParty::Banner.new(nil, { "BannerType" => expected_valid_bannertype, "BannerType2" => expected_valid_bannerytype2 })
        expect(record.banner_type_2).to be_an_instance_of(String)
        expect(record.banner_type_2).to eq(expected_valid_bannerytype2)
      end
    end
  end

  it 'should have a nil secondary banner type, if the primary banner type is valid, but the specified secondary banner type is invalid' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType" => "poster", "BannerType2" => "abcdef" })
    expect(record.banner_type_2).to be_nil
  end

  it 'should have a nil secondary banner type, if the primary banner type is valid, but the specified secondary banner type is invalid for that primary banner type' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType" => "poster", "BannerType2" => "seasonwide" })
    expect(record.banner_type_2).to be_nil
  end

  it 'should have a nil secondary banner type, if the primary banner type is nil' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType2" => "seasonwide" })
    expect(record.banner_type_2).to be_nil
  end

  it 'should have a language associated with it' do
    record = TheTvDbParty::Banner.new(nil, { "Language" => "en" })
    expect(record.language).to be_an_instance_of(String)
    expect(record.language.length).to be_between(2, 3).inclusive
    expect(record.language).to eq("en")
  end

  it 'should have a nil language, if the language is not specified' do
    record = TheTvDbParty::Banner.new(nil, {  })
    expect(record.language).to be_nil
  end

  it 'should have a season' do
    record = TheTvDbParty::Banner.new(nil, { "Season" => "5" })
    expect(record.season).to be_an_instance_of(Fixnum)
    expect(record.season).to be >= 0
  end

  it 'should have a nil season, if it is not specified' do
    record = TheTvDbParty::Banner.new(nil, {  })
    expect(record.season).to be_nil
  end

  it 'should have a rating' do
    record = TheTvDbParty::Banner.new(nil, { "Rating" => "6.6667" })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be >= 0.0
    expect(record.rating).to be 6.6667
  end

  it 'should have a zero rating, if invalid specified' do
    record = TheTvDbParty::Banner.new(nil, { "Rating" => "INVALID_RATING" })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be 0.0
  end

  it 'should have a zero rating, if it is not specified' do
    record = TheTvDbParty::Banner.new(nil, {  })
    expect(record.rating).to be_an_instance_of(Float)
    expect(record.rating).to be 0.0
  end

  it 'should have a rating count' do
    record = TheTvDbParty::Banner.new(nil, { "RatingCount" => "6" })
    expect(record.rating_count).to be_an_instance_of(Fixnum)
    expect(record.rating_count).to be >= 0
    expect(record.rating_count).to eq(6)
  end

  it 'should have a zero rating count, if it is not specified' do
    record = TheTvDbParty::Banner.new(nil, {  })
    expect(record.rating_count).to be_an_instance_of(Fixnum)
    expect(record.rating_count).to be 0
  end

  it 'should have a true series name flag' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType" => "fanart", "SeriesName" => "true" })
    expect(record.series_name).to be_an_instance_of(TrueClass).or be_an_instance_of(FalseClass)
    expect(record.series_name).to be true
  end

  it 'should have a false series name flag, if banner type is not fanart' do
    [ "poster", "series", "season" ].each do |expected_valid_bannertype|
      record = TheTvDbParty::Banner.new(nil, { "BannerType" => expected_valid_bannertype, "SeriesName" => "true" })
      expect(record.series_name).to be_an_instance_of(TrueClass).or be_an_instance_of(FalseClass)
      expect(record.series_name).to be false
    end
  end

  it 'should have a false series name flag, if it is not specified' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType" => "fanart" })
    expect(record.series_name).to be_an_instance_of(TrueClass).or be_an_instance_of(FalseClass)
    expect(record.series_name).to be false
  end

  it 'should have a zero rating count, if it is not specified' do
    record = TheTvDbParty::Banner.new(nil, {  })
    expect(record.rating_count).to be_an_instance_of(Fixnum)
    expect(record.rating_count).to be 0
  end

  it 'should have the color fields' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType" => "fanart", "Colors" => "|81,81,81|15,15,15|201,226,246|" })
    expect(record.light_accent_color).to be_an_instance_of(Array)
    expect(record.light_accent_color).to match_array([81, 81, 81])
    expect(record.dark_accent_color).to be_an_instance_of(Array)
    expect(record.dark_accent_color).to match_array([15, 15, 15])
    expect(record.neutral_midtone_color).to be_an_instance_of(Array)
    expect(record.neutral_midtone_color).to match_array([201, 226, 246])
  end

  it 'should have nil color fields, if banner type is not fanart' do
    record = TheTvDbParty::Banner.new(nil, { "Colors" => "|81,81,81|15,15,15|201,226,246|" })
    expect(record.light_accent_color).to be_nil
    expect(record.dark_accent_color).to be_nil
    expect(record.neutral_midtone_color).to be_nil
  end

  it 'should have nil color fields, if invalid colors are specified' do
    record = TheTvDbParty::Banner.new(nil, { "Colors" => "INVALID_COLORS" })
    expect(record.light_accent_color).to be_nil
    expect(record.dark_accent_color).to be_nil
    expect(record.neutral_midtone_color).to be_nil
  end

  it 'should have nil color fields, if no colors are specified' do
    record = TheTvDbParty::Banner.new(nil, {  })
    expect(record.light_accent_color).to be_nil
    expect(record.dark_accent_color).to be_nil
    expect(record.neutral_midtone_color).to be_nil
  end

  it 'should have nil color fields, if colors are specified, but at least one of the colors does not have exactly three elements' do
    record = TheTvDbParty::Banner.new(nil, { "BannerType" => "fanart", "Colors" => "|81,81,81,4|15,15,15|201,226,246|" })
    expect(record.light_accent_color).to be_nil
    expect(record.dark_accent_color).to be_nil
    expect(record.neutral_midtone_color).to be_nil
  end

  it 'should not instantiate when created without hash values' do
    expect { TheTvDbParty::Banner.new(nil, nil) }.to raise_error
  end
end
