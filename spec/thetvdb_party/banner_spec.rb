require 'rspec'
require 'thetvdb_party'

describe 'Banner' do

  before(:each) do
    @valid_banner = TheTvDbParty::Banner.new(nil,
      {
          "id" => "0"
      }
    )
    @invalid_banner = TheTvDbParty::Banner.new(nil, { })
  end

  it 'should have an id when valid' do
    expect @valid_banner.id == 0
  end

  it 'should have a negative id when invalid' do
    expect @invalid_banner.id < 0
  end

  it 'should not instantiate when created without hash values' do
    expect{TheTvDbParty::Banner.new(nil, nil)}.to raise_error
  end
end
