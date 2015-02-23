require 'rspec'
require 'thetvdb_party'

describe 'Actor' do

  before(:each) do
    @valid_actor = TheTvDbParty::Actor.new(nil,
      {
          "id" => "0"
      }
    )
    @invalid_actor = TheTvDbParty::Actor.new(nil, { })
  end

  it 'should have an id when valid' do
    expect @valid_actor.id == 0
  end

  it 'should have a negative id when invalid' do
    expect @invalid_actor.id < 0
  end

  it 'should not instantiate when created without hash values' do
    expect{TheTvDbParty::Actor.new(nil, nil)}.to raise_error
  end
end
