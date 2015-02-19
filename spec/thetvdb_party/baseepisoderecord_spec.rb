require 'rspec'
require 'thetvdb_party'

describe 'BaseEpisodeRecord' do

  before(:each) do
    @valid_record = TheTvDbParty::BaseEpisodeRecord.new(nil,
      {
          "id" => "0"
      }
    )
    @invalid_record = TheTvDbParty::BaseEpisodeRecord.new(nil, { })
  end

  it 'should have an id when valid' do
    expect @valid_record.id == 0
  end

  it 'should have a negative id when invalid' do
    expect @invalid_record.id < 0
  end

  it 'should not instantiate when created without hash values' do
    expect{TheTvDbParty::BaseEpisodeRecord.new(nil, nil)}.to raise_error
  end
end
