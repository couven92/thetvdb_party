module TheTvDbParty
  # The Base Episode Record contains all of the information available about an episode.
  # Remarks::   The fields #airsafter_season, #airsbefore_episode, and #airsbefore_season will only be included when the
  #             episode is listed as a special. Specials are also listed as being in season +0+, so they're easy to
  #             identify and sort.
  #
  #             #dvd_episodenumber is a decimal and can be used to join episodes together. Usually used to join episodes
  #             that aired as two episodes but were released on DVD as a single episode. Normally there would be no
  #             decimal value but if you see an episode +1.1+ and +1.2+ that means both records should be combined to
  #             make episode +1+. Cartoons are also known to combine up to 9 episodes together,
  #             for example {Animaniacs season two}[http://www.thetvdb.com/index.php?tab=season&seriesid=72879&seasonid=4931&lid=7&order=dvd].
  # See Also::  http://thetvdb.com/wiki/index.php?title=API:Base_Episode_Record
  class BaseEpisodeRecord

    attr_reader :client
    # An unsigned integer assigned by TheTvDb to the episode. Negative, if invalid.
    attr_reader :id
    # A decimal. Negative, if invalid. This returns the value of #dvd_episodenumber if that field is not
    # null. Otherwise it returns the value from #episodenumber.
    # Remarks:: The field can be used as a simple way of prioritizing DVD order over aired order in your program.
    #           In general it's best to avoid using this field as you can accomplish the same task locally and have
    #           more control if you use the #dvd_episodenumber and #episodenumber fields separately.
    attr_reader :combined_episodenumber
    # A decimal. Negative, if invalid. This returns the value of #dvd_season if that field is not null. Otherwise it returns
    # the value from #seasonnumber.
    # Remarks:: The field can be used as a simple way of prioritizing DVD order over aired order in your program.
    #           In general it's best to avoid using this field as you can accomplish the same task locally and have
    #           more control if you use the #dvd_season and #seasonnumber fields separately.
    attr_reader :combined_season
    # Deprecated, was meant to be used to aid in scrapping of actual DVD's but has never been populated properly.
    # Any information returned in this field shouldn't be trusted. Will usually be null.
    attr_reader :dvd_chapter
    # Deprecated, was meant to be used to aid in scrapping of actual DVD's but has never been populated properly.
    # Any information returned in this field shouldn't be trusted. Will usually be null.
    attr_reader :dvd_discid
    # A decimal with one decimal and can be used to join episodes together. Negative if invalid,
    # usually used to join episodes that aired as two episodes but were released on DVD as a single episode.
    # If you see an episode +1.1+ and +1.2+ that means both records should be combined to make episode +1+.
    # Cartoons are also known to combine up to 9 episodes together,
    # for example {Animaniacs season two}[http://www.thetvdb.com/index.php?tab=season&seriesid=72879&seasonid=4931&lid=7&order=dvd].
    attr_reader :dvd_episodenumber
    # An unsigned integer indicating the season the episode was in according to the DVD release.
    # Usually is the same as #seasonnumber but can be different.
    # Negative, if invalid
    attr_reader :dvd_season
    # An array of directors in plain text. Empty, if none are listed.
    attr_reader :director
    # An unsigned integer, +0+ (zero) if no image is associated with the episode.
    # Values::
    #   +1+::   4:3 - Indicates an image is a proper 4:3 (1.31 to 1.35) aspect ratio.
    #   +2+::   16:9 - Indicates an image is a proper 16:9 (1.739 to 1.818) aspect ratio.
    #   +3+::   Invalid Aspect Ratio - Indicates anything not in a 4:3 or 16:9 ratio. We don't bother listing any other non standard ratios.
    #   +4+::   Image too Small - Just means the image is smaller than 300x170.
    #   +5+::   Black Bars - Indicates there are black bars along one or all four sides of the image.
    #   +6+::   Improper Action Shot - Could mean a number of things, usually used when someone uploads a promotional
    #           picture that isn't actually from that episode but does refrence the episode, it could also mean it's a
    #           credit shot or that there is writting all over it. It's rarely used since most times an image would just
    #           be outright deleted if it falls in this category.
    # Remarks:: If it's +1+ or +2+ TheTvDb assumes it's a proper image, anything above +2+ is considered incorrect and can be replaced by anyone with an account.
    attr_reader :epimgflag
    # A string containing the episode name in the language requested. Will return the English name if no translation is available in the language requested.
    attr_reader :episodename
    # An unsigned integer representing the episode number in its season according to the aired order. Negative, if invalid.
    attr_reader :episodenumber
    # The date the series first aired. +nil+ if not known.
    attr_reader :firstaired
    # An array of the guest stars in that episode. Empty, if none are listed.
    attr_reader :gueststars
    # An alphanumeric string containing the IMDB ID for the series. Can be null.
    attr_reader :imdb_id
    # A two character string indicating the language in accordance with ISO-639-1. Cannot be null.
    attr_reader :language
    # A string containing the overview in the language requested. Will return the English overview if no translation is available in the language requested. Can be null.
    attr_reader :overview
    # An alphanumeric string. Can be null.
    attr_reader :productioncode
    # The average rating users have rated the series out of 10, rounded to 1 decimal place.
    attr_reader :rating
    # An unsigned integer representing the number of users who have rated the series.
    attr_reader :ratingcount
    # An unsigned integer representing the season number for the episode according to the aired order. Negative, if invalid.
    attr_reader :seasonnumber
    # An array of the writers of the episode. Empty, if none are listed.
    attr_reader :writer
    # An unsigned integer. Negative, if invalid.
    # Remarks:: Indicates the absolute episode number and completely ignores seasons.
    #           In others words a series with 20 episodes per season will have Season +3+ episode +10+ listed as +50+.
    #           The field is mostly used with cartoons and anime series as they may have ambiguous seasons making it
    #           easier to use this field.
    attr_reader :absolute_number
    # An unsigned integer indicating the season number this episode comes after. This field is only available for special episodes.
    # Negative, if unavailable.
    attr_reader :airsafter_season
    # An unsigned integer indicating the episode number this special episode airs before.
    # Must be used in conjunction with #airsbefore_season, and not with #airsafter_season.
    # This field is only available for special episodes.
    # Negative, if unavailable.
    attr_reader :airsbefore_episode
    # An unsigned integer indicating the season number this special episode airs before.
    # Should be used in conjunction with #airsbefore_episode for exact placement.
    # This field is only available for special episodes.
    # Negative, if unavailable.
    attr_reader :airsbefore_season
    # Returns the relative path of the episode image. +nil+ if unavailable.
    attr_reader :imagepath_relative
    # Returns the full URI of the episode image. +nil+ if unavailable.
    attr_reader :imagepath_full
    # The last time any changes were made to the episode record. +nil+, if unavailable.
    attr_reader :lastupdated
    # An unsigned integer assigned by TheTvDb to the season. Negative, if invalid.
    attr_reader :seasonid
    # An unsigned integer assigned by TheTvDb to the series. It does not change and will always represent the same series.
    # Negative, if invalid.
    attr_reader :seriesid
    # The date and time the episode image was added to the TheTvDb site. +nil+, if unavailable.
    attr_reader :thumb_added
    # An unsigned integer that represents the height of the episode image in pixels. +0+, if not specified.
    attr_reader :thumb_height
    # An unsigned integer that represents the width of the episode image in pixels. +0+, if not specified.
    attr_reader :thumb_width

    # Initializes a new Base Episode Record as it was retrieved from a given client.
    # Parameters::
    #   +client+::      The TheTvDbParty::Client instance that retrieved the record.
    #   +hashValues+::  A Hash{String => String} instance that maps the record element names to their string values.
    def initialize(client, hashValues)
      @client = client
      @hashValues = hashValues

      read_hash_values
    end

    # Retrieves the Base Series Record for the series this episode belongs to.
    # Returns::   A TheTvDbParty::BaseSeriesRecord instance that represents the series, or +nil+ if the series record could not be retrieved.
    # See Also::  TheTvDbParty::Client#get_base_series_record
    def get_base_series_record
      @client.get_base_series_record @seriesid
    end

    private
    def read_hash_values
      @id = @hashValues["id"] ? @hashValues["id"].to_i : -1
      @combined_episodenumber = @hashValues["Combined_episodenumber"] ? @hashValues["Combined_episodenumber"].to_f : -1.0
      @combined_season = @hashValues["Combined_season"] ? @hashValues["Combined_season"].to_f : -1.0
      @dvd_chapter = @hashValues["DVD_chapter"]
      @dvd_discid = @hashValues["DVD_discid"]
      @dvd_episodenumber = @hashValues["DVD_episodenumber"] ? @hashValues["DVD_episodenumber"].to_f : -1.0
      @dvd_season = @hashValues["DVD_season"] ? @hashValues["DVD_season"].to_i : -1
      @director = @hashValues["Director"] ? @hashValues["Director"].split('|').reject { |a| a.nil? || a.empty? } : []
      @epimgflag = @hashValues["EpImgFlag"] ? @hashValues["EpImgFlag"].to_i : 0
      @episodename = @hashValues["EpisodeName"]
      @episodenumber = @hashValues["EpisodeNumber"] ? @hashValues["EpisodeNumber"].to_i : -1
      @firstaired = @hashValues["FirstAired"] ? Date.parse(@hashValues["FirstAired"].to_i) : nil
      @gueststars = @hashValues["GuestStars"] ? @hashValues["GuestStars"].split('|').reject { |a| a.nil? || a.empty? } : []
      @imdb_id = @hashValues["IMDB_ID"]
      @language = @hashValues["Language"]
      @overview = @hashValues["Overview"]
      @productioncode = @hashValues["ProductionCode"]
      @rating = @hashValues["Rating"] ? @hashValues["Rating"].to_f : 0.0
      @ratingcount = @hashValues["RatingCount"] ? @hashValues["RatingCount"].to_i : 0
      @seasonnumber = @hashValues["SeasonNumber"] ? @hashValues["SeasonNumber"].to_i : -1
      @writer = @hashValues["Writer"] ? @hashValues["Writer"].split('|').reject { |a| a.nil? || a.empty? } : []
      @absolute_number = @hashValues["absolute_number"] ? @hashValues["absolute_number"].to_i : -1
      @airsafter_season = @hashValues["airsafter_season"] ? @hashValues["airsafter_season"].to_i : -1
      @airsbefore_episode = @hashValues["airsbefore_episode"] ? @hashValues["airsbefore_episode"].to_i : -1
      @airsbefore_season = @hashValues["airsbefore_season"] ? @hashValues["airsbefore_season"].to_i : -1
      @imagepath_relative = @hashValues["filename"]
      @imagepath_full = @imagepath_relative ? URI::join(BASE_URL, 'banners/', @imagepath_relative) : nil
      @lastupdated = @hashValues["lastupdated"] ? Time.at(@hashValues["lastupdated"].to_i).to_datetime : nil
      @seasonid = @hashValues["seasonid"] ? @hashValues["seasonid"].to_i : -1
      @seriesid = @hashValues["seriesid"] ? @hashValues["seriesid"].to_i : -1
      @thumb_added = @hashValues["thumb_added"] ? Date.parse(@hashValues["thumb_added"]) : nil
      @thumb_height = @hashValues["thumb_height"] ? @hashValues["thumb_height"].to_i : 0
      @thumb_width = @hashValues["thumb_width"] ? @hashValues["thumb_width"].to_i : 0

      nil
    end
  end
end
