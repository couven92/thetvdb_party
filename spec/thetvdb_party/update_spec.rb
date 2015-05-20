require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::Update' do
  it 'should have a client associated with it' do
    client = TheTvDbParty::Client.new(nil)
    record = TheTvDbParty::Update.new(client, { },false)
    expect(record.client).to be_an_instance_of(TheTvDbParty::Client)
  end

  it 'should have a nil client if constructed with nil' do
    record = TheTvDbParty::Update.new(nil, { },false)
    expect(record.client).to be_nil
  end
  
  it 'should read timestamp when passed hashed XML with timestamp (last timestamp format)' do
    record = TheTvDbParty::Update.new(nil,{"Items"=>{"Time"=>"1432052332"}},false)
    expect(record.timestamp).to_not be_nil
    expect(record.timestamp).to eq("1432052332")
  end
  it 'should read series when passed hashed XML with series data (last timestamp format)' do
    record = TheTvDbParty::Update.new(nil,{"Items"=>{"Series"=>["123","234","345"]}},false)
    expect(record.series).to_not be_nil
    expect(record.series).to match_array([{:seriesid=>"123",:updatetime=>nil},{:seriesid=>"234",:updatetime=>nil},{:seriesid=>"345",:updatetime=>nil}])
  end
  it 'should read episodes when passed hashed XML with series data (last timestamp format)' do
    record = TheTvDbParty::Update.new(nil,{"Items"=>{"Episode"=>["123","234","345"]}},false)
    expect(record.episodes).to_not be_nil
    expect(record.episodes).to match_array([{:episodeid=>"123",:seriesid=>nil,:updatetime=>nil},{:episodeid=>"234",:seriesid=>nil,:updatetime=>nil},{:episodeid=>"345",:seriesid=>nil,:updatetime=>nil}])
  end
  it 'should not have data not passed in (last timestamp format)' do
    record = TheTvDbParty::Update.new(nil,{"Items"=>{"Episode"=>["123","234","345"]}},false)
    expect(record.series).to be_nil
    expect(record.timestamp).to be_nil
    expect(record.banners).to be_nil
    record = TheTvDbParty::Update.new(nil,{"Items"=>{"Series"=>["123","234","345"]}},false)
    expect(record.episodes).to be_nil
    expect(record.timestamp).to be_nil
    expect(record.banners).to be_nil
    record = TheTvDbParty::Update.new(nil,{"Items"=>{"Time"=>"1432052332"}},false)
    expect(record.episodes).to be_nil
    expect(record.series).to be_nil
    expect(record.banners).to be_nil
  end
  it 'should read timestamp when passed hashed XML with timestamp (timeframe format)' do
    data = {"Data"=>{"time"=>"1432053001"}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.timestamp).to_not be_nil
    expect(record.timestamp).to eq("1432053001")
  end
  it 'should read series when passed hashed XML with timestamp (timeframe format)' do
    data = {"Data"=>{"Series"=>[{"id"=>"70328", "time"=>"1431972440"}, {"id"=>"70383", "time"=>"1431973145"}]}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.series).to_not be_nil
    expect(record.series).to match_array([{:seriesid=>"70328",:updatetime=>"1431972440"},{:seriesid=>"70383",:updatetime=>"1431973145"}])
  end
  it 'should read episodes when passed hashed XML with timestamp (timeframe format)' do
    data = {"Data"=>{"Episode"=>[{"id"=>"5229051", "Series"=>"295317", "time"=>"1431966617"}, {"id"=>"5229389", "Series"=>"285520", "time"=>"1431966652"}]}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.episodes).to_not be_nil
    expect(record.episodes).to match_array([{:episodeid=>"5229051",:seriesid=>"295317",:updatetime=>"1431966617"},{:episodeid=>"5229389",:seriesid=>"285520",:updatetime=>"1431966652"}])
  end
  it 'should read banners when passed hashed XML with timestamp (timeframe format)' do
    data = {"Data"=>{"Banner"=>[{"SeasonNum"=>"1", "Series"=>"253534", "format"=>"standard", "language"=>"nl", "path"=>"seasons/253534-1-3.jpg", "time"=>"1431987040", "type"=>"season"}, {"Series"=>"294169", "format"=>"1920x1080", "path"=>"fanart/original/294169-4.jpg", "time"=>"1431987428", "type"=>"fanart"}]}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.banners).to_not be_nil
    expect(record.banners).to match_array([{:path=>"seasons/253534-1-3.jpg",:format=>"standard",:type=>"season",:seriesid=>"253534",:seasonnum=>"1",:language=>"nl",:updatetime=>"1431987040"},
      {:path=>"fanart/original/294169-4.jpg",:format=>"1920x1080",:type=>"fanart",:seriesid=>"294169",:seasonnum=>nil,:language=>nil,:updatetime=>"1431987428"}])
  end
  it 'should not have data not passed in (timeframe format)' do
    data = {"Data"=>{"time"=>"1432053001"}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.episodes).to be_nil
    expect(record.series).to be_nil
    expect(record.banners).to be_nil
    data = {"Data"=>{"Series"=>[{"id"=>"70328", "time"=>"1431972440"}, {"id"=>"70383", "time"=>"1431973145"}]}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.episodes).to be_nil
    expect(record.timestamp).to be_nil
    expect(record.banners).to be_nil
    data = {"Data"=>{"Episode"=>[{"id"=>"5229051", "Series"=>"295317", "time"=>"1431966617"}, {"id"=>"5229389", "Series"=>"285520", "time"=>"1431966652"}]}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.series).to be_nil
    expect(record.timestamp).to be_nil
    expect(record.banners).to be_nil
    data = {"Data"=>{"Banner"=>[{"SeasonNum"=>"1", "Series"=>"253534", "format"=>"standard", "language"=>"nl", "path"=>"seasons/253534-1-3.jpg", "time"=>"1431987040", "type"=>"season"}, {"Series"=>"294169", "format"=>"1920x1080", "path"=>"fanart/original/294169-4.jpg", "time"=>"1431987428", "type"=>"fanart"}]}}
    record = TheTvDbParty::Update.new(nil,data,false)
    expect(record.series).to be_nil
    expect(record.timestamp).to be_nil
    expect(record.episodes).to be_nil
  end
  ### Unable to get Zipping to work in this test
  #it 'should read zipped data' do
  #  Zip::ZipOutputStream::open("my.zip") {
  #  |io|
  #
  #  io.put_next_entry("first_entry.txt")
  #  io.write "Hello world!"
  #
  #  io.put_next_entry("adir/first_entry.txt")
  #  io.write "Hello again!"
  #}
  #end
end