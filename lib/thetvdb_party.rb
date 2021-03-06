require 'httparty'
require 'zip'

require 'thetvdb_party/update'
require 'thetvdb_party/baseseriesrecord'
require 'thetvdb_party/fullseriesrecord'
require 'thetvdb_party/baseepisoderecord'
require 'thetvdb_party/client'
require 'thetvdb_party/searchseriesrecord'
require 'thetvdb_party/actor'
require 'thetvdb_party/banner'
require 'thetvdb_party/version'
require 'thetvdb_party/banner'
require 'thetvdb_party/actor'
require 'thetvdb_party/all'

# thetvdb_party gem root namespace
module TheTvDbParty
  # The base url for the TheTvDB API
  BASE_URL = 'http://thetvdb.com/'
end
