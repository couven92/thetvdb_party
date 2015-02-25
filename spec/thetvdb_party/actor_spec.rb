require 'rspec'
require 'thetvdb_party'

describe 'TheTvDbParty::Actor' do
  it 'should have a client associated with it' do
    client = TheTvDbParty::Client.new(nil)
    record = TheTvDbParty::Actor.new(client, { })
    expect(record.client).to be_an_instance_of(TheTvDbParty::Client)
  end

  it 'should have a nil client if constructed with nil' do
    record = TheTvDbParty::Actor.new(nil, { })
    expect(record.client).to be_nil
  end

  it 'should have an ignored id field' do
    record = TheTvDbParty::Actor.new(nil, { "id" => "27747" })
    expect(record.id).to be_an_instance_of(String)
    expect(record.id).to eq("27747")
  end

  it 'should have a nil id, if not specified' do
    record = TheTvDbParty::Actor.new(nil, {})
    expect(record.id).to be_nil
  end

  it 'should have a relative/full image path' do
    record = TheTvDbParty::Actor.new(nil, { "Image" => "actors/27747.jpg" })
    expect(record.image_path_relative).to be_an_instance_of(String)
    expect(record.image_path_full).to be_an_instance_of(URI::Generic)
    expect(record.image_path_relative).to eq("actors/27747.jpg")
    expect(record.image_path_full).to eq(URI::join(TheTvDbParty::BASE_URL, 'banners/', 'actors/27747.jpg'))
  end

  it 'should have a nil relative/full image path, if not specified' do
    record = TheTvDbParty::Actor.new(nil, {})
    expect(record.image_path_relative).to be_nil
    expect(record.image_path_full).to be_nil
  end

  it 'should have a name field' do
    record = TheTvDbParty::Actor.new(nil, { "Name" => "Matthew Fox" })
    expect(record.name).to be_an_instance_of(String)
    expect(record.name).to eq("Matthew Fox")
  end

  it 'should have a nil name, if not specified' do
    record = TheTvDbParty::Actor.new(nil, {})
    expect(record.name).to be_nil
  end

  it 'should have a sorting order between 0-3' do
    record = TheTvDbParty::Actor.new(nil, { "SortOrder" => "2" })
    expect(record.sort_order).to be_an_instance_of(Fixnum)
    expect(record.sort_order).to be_between(0, 3).inclusive
    expect(record.sort_order).to eq(2)
  end

  it 'should have a 0 sorting order, if invalid specified' do
    record = TheTvDbParty::Actor.new(nil, { "SortOrder" => "INVALID_SORT_ORDER" })
    expect(record.sort_order).to be_an_instance_of(Fixnum)
    expect(record.sort_order).to be_between(0, 3).inclusive
    expect(record.sort_order).to eq(0)
  end

  it 'should have a 0 sorting order, if invalid specified' do
    record = TheTvDbParty::Actor.new(nil, {  })
    expect(record.sort_order).to be_an_instance_of(Fixnum)
    expect(record.sort_order).to be_between(0, 3).inclusive
    expect(record.sort_order).to eq(0)
  end

  it 'should not instantiate when created without hash values' do
    expect { TheTvDbParty::Actor.new(nil, nil) }.to raise_error
  end
end
