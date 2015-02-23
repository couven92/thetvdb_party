require 'rspec'
require 'thetvdb_party'

describe 'BaseSeriesRecord' do
  before(:each) do
    @valid_record = TheTvDbParty::BaseSeriesRecord.new(nil,
      {
        "id" => "0"
      }
    )
    @invalid_record = TheTvDbParty::BaseSeriesRecord.new(nil, { })
  end

  it "should have valid id if valid" do
    expect @valid_record.id == 0
  end

  it "should have negative id if series not found or invalid" do
    expect @invalid_record.id < 0
  end

  it "must have a hash to be created" do
    expect(TheTvDbParty::BaseSeriesRecord.new(nil, nil)).to raise_error
end