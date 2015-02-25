# TheTvDbParty [![Gem Version](https://badge.fury.io/rb/thetvdb_party.svg)](http://badge.fury.io/rb/thetvdb_party)

The thetvdb_party gem accesses the TheTvDB programmers API as it is described on http://thetvdb.com/wiki/index.php/Programmers_API

It uses compression to minimize bandwith when accessing Full Series Records.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thetvdb_party'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thetvdb_party

## Usage

### Creating a TheTvDb API client

To create a new client without an api key:

```ruby
client = TheTvDbParty::Client.new
```

Or with an api key:

```ruby
client = TheTvDbParty::Client.new "<your api key>"
```

It is recommended to use an `.env` file or environment variable to store the API key.
For example like this:

Contents of `.env`

    TVDB_API_KEY=<YOUR API KEY>

### Performing searches

Once you have a client instance, you can perform searches against the TheTvDb API.
The following example searches for `The Mentalist` on TheTvDb.

```ruby
results = client.search "The Mentalist"
```

The `#search` method of the client returns an array containing the search results. Iterate over this array to get
the **Base Series Record** of the search results.

```ruby
results.each do |search_result_record|
  base_series_record = search_result_record.get_base_series_record
end
```


## Contributing

1. Fork it ( https://github.com/couven92/thetvdb_party/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
