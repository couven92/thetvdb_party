module TheTvDbParty
  # The Base Series Record contains all of the information available about a series. It does not include any banner, season, or episode information.
  # See Also::  http://thetvdb.com/wiki/index.php?title=API:Base_Series_Record
  class BaseSeriesRecord

    # The client instance that retrieved this record.
    # Returns a TheTvDbParty::Client instance
    attr_reader :client

    # An unsigned integer assigned by our site to the series. It does not change and will always represent the same series. Cannot be null.
    attr_reader :seriesid
    # An array containing the names of actors as string values. Empty if none are listed.
    attr_reader :actors
    # The date/time the series was added to the TheTvDb site. Can be null for older series.
    attr_reader :added
    # An unsigned integer. The ID of the user on our site who added the series to our database. Is nil for older series.
    attr_reader :addedby
    # The full name in English for the day of the week the series airs in plain text. Can be null.
    attr_reader :airs_dayofweek
    # The time of day the series airs on its original network. Can be null.
    attr_reader :airs_time
    # The full path for the highest rated banner for the series, returned as a URI instance.
    attr_reader :bannerpath_full
    # The relative path to the highest rated banner for this series. Retrieve #bannerpath_full get the absolute path.
    attr_reader :bannerpath_relative
    # The rating given to the series based on the US rating system. Can be null or a 4-5 character string.
    attr_reader :contentrating
    # The full path for the highest rated fanart for the series, returned as a URI instance.
    attr_reader :fanartpath_full
    # The relative path to the highest rated fanart for this series. Retrieve #fanartpath_full get the absolute path.
    attr_reader :fanartpath_relative
    # The date the series first aired as a Date instance
    attr_reader :firstaired
    # A list of genres in plain text. Empty if none are listed.
    attr_reader :genres
    # An alphanumeric string containing the IMDB ID for the series. Can be null.
    attr_reader :imdb_id
    # A two character string indicating the language in accordance with ISO-639-1. Cannot be null.
    attr_reader :language
    # The time and date of the last time any changes were made to the series. Can be nil
    attr_reader :lastupdated
    # A string containing the network name in plain text. Can be null.
    attr_reader :network
    # Not in use, will be an unsigned integer if ever used. Can be null.
    attr_reader :networkid
    # A string containing the overview in the language requested. Will return the English overview if no translation is available in the language requested. Can be null.
    attr_reader :overview
    # The full path for the highest rated poster for the series, returned as a URI instance.
    attr_reader :posterpath_full
    # The relative path to the highest rated poster for this series. Retrieve #posterpath_full get the absolute path.
    attr_reader :posterpath_relative
    # The average rating our users have rated the series out of 10, rounded to 1 decimal place.
    attr_reader :rating
    # An unsigned integer representing the number of users who have rated the series.
    attr_reader :ratingcount
    # An unsigned integer representing the runtime of the series in minutes. Negative if unknown.
    attr_reader :runtime
    # Deprecated. An unsigned integer representing the series ID at tv.com. As TV.com now only uses these ID's internally it's of little use and no longer updated. Can be null.
    attr_reader :tvcom_id
    # A string containing the series name in the language you requested. Will return the English name if no translation is found in the language requested. Can be null if the name isn't known in the requested language or English.
    attr_reader :seriesname
    # A string containing either "Ended" or "Continuing". Can be null.
    attr_reader :status
    attr_reader :tvcom_id
    # An alphanumeric string containing the zap2it id. Can be nil.
    attr_reader :zap2it_id

    # Initializes a new BaseSeriesRecord from the hash that was retrieved by a given client
    # Parameters::
    #   +client+::      The TheTvDbParty::Client instance that retrieved the record
    #   +hashValues+::  A +Hash{String => String}+ instance that maps the record attribute element names against their values
    def initialize(client, hashValues)
      @client = client
      @hashValues = hashValues

      read_hash_values
    end

    # Retrieves episode information of an episode in the series by season and episode number according to default sorting order
    # Parameters::
    #   +season_number+::   The number of the season in which the episode appeared.
    #   +episode_number+::  The episode number within the season.
    # Returns::     A TheTvDbParty::BaseEpisodeRecord instance that represents the episode, or +nil+ if the episode could not be found.
    # Remarks::     Specials episodes are ordered within season +0+. Attributes within the returned record indicate at which time (i.e. between which episode the episode should be ordered)
    # See Also::    TheTvDbParty::Client#get_series_season_episode, #get_dvd_season_episode, #get_absolute_episode
    def get_season_episode(season_number, episode_number)
      @client.get_series_season_episode @seriesid, season_number, episode_number
    end

    # Retrieves episode information of an episode in the series by season and episode number according to DVD sorting order
    # Parameters::
    #   +season_number+::   The number of the season in which the episode appeared.
    #   +episode_number+::  The episode number within the season.
    # Returns::     A TheTvDbParty::BaseEpisodeRecord instance that represents the episode, or +nil+ if the episode could not be found.
    # Remarks::     Specials episodes are ordered within season +0+. Attributes within the returned record indicate at which time (i.e. between which episode the episode should be ordered)
    # See Also::    TheTvDbParty::Client#get_series_dvd_season_episode, #get_season_episode, #get_absolute_episode
    def get_dvd_season_episode(season_number, episode_number)
      @client.get_series_dvd_season_episode @seriesid, season_number, episode_number
    end

    # Retrieves episode information of an episode in the series by season and episode number according to absolute sorting order
    # Parameters::
    #   +episode_number+::  The episode number within the series.
    # Returns::     A TheTvDbParty::BaseEpisodeRecord instance that represents the episode, or +nil+ if the episode could not be found.
    # See Also::    TheTvDbParty::Client#get_series_absolute_episode, #get_season_episode, #get_dvd_season_episode
    def get_absolute_episode(episode_number)
      @client.get_series_absolute_episode @seriesid, episode_number
    end

    private
    def read_hash_values
      @seriesid = @hashValues["id"] ? @hashValues["id"].to_i : -1
      @actors = @hashValues["Actors"] ? @hashValues["Actors"].split('|').reject { |a| a.nil? || a.empty? } : []
      @airs_dayofweek = @hashValues["Airs_DayOfWeek"]
      @airs_time = @hashValues["Airs_Time"] ? Time.parse(@hashValues["Airs_Time"]) : nil
      @contentrating = @hashValues["ContentRating"]
      @firstaired = @hashValues["FirstAired"] ? Date.parse(hashValues["FirstAired"]) : nil
      @genres = @hashValues["Genre"] ? @hashValues["Genre"].split('|').reject { |a| a.nil? || a.empty? } : []
      @imdb_id = @hashValues["IMDB_ID"]
      @language = @hashValues["Language"]
      @network = @hashValues["Network"]
      @networkid = @hashValues["NetworkID"] ? @hashValues["NetworkID"].to_i : -1
      @overview = @hashValues["Overview"]
      @rating = @hashValues["Rating"] ? @hashValues["Rating"].to_f : 0.0
      @ratingcount = @hashValues["RatingCount"] ? @hashValues["RatingCount"].to_i : 0
      @runtime = @hashValues["Runtime"] ? @hashValues["Runtime"].to_i : -1
      @tvcom_id = @hashValues["SeriesID"] ? @hashValues["SeriesID"].to_i : nil
      @seriesname = @hashValues["SeriesName"]
      @status = @hashValues["Status"]
      @added = @hashValues["added"] ? DateTime.parse(@hashValues["added"]) : nil
      @addedby = @hashValues["addedBy"] ? @hashValues["addedBy"].to_i : nil
      @bannerpath_relative = @hashValues["banner"]
      @fanartpath_relative = @hashValues["fanart"]
      @posterpath_relative = @hashValues["poster"]
      @zap2it_id = @hashValues["zap2it_id"]
      @lastupdated = @hashValues["lastupdated"] ? Time.at(@hashValues["lastupdated"].to_i).to_datetime : nil
      @bannerpath_full = @bannerpath_relative ? URI::join(BASE_URL, "banners/", @bannerpath_relative) : nil
      @fanartpath_full = @fanartpath_relative ? URI::join(BASE_URL, "banners/", @fanartpath_relative) : nil
      @posterpath_full = @posterpath_relative ? URI::join(BASE_URL, "banners/", @posterpath_relative) : nil

      nil
    end
  end
end
