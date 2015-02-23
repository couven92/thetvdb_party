module TheTvDbParty
  # Represents one record within the search results for a series search
  # See Also::  http://thetvdb.com/wiki/index.php?title=API:GetSeries
  class SearchSeriesRecord

    # The client instance that retrieved this record
    attr_reader :client
    # *Deprecated:* #id is only included to be backwards compatible with the old API and is deprecated.
    #
    # The unique TheTvDb identifier to access the more detailed Base Series Record and Full Series Record.
    # See Also::  #seriesid
    attr_reader :id
    # The unique TheTvDb identifier to access the more detailed Base Series Record and Full Series Record.
    # Negative, if invalid.
    attr_reader :seriesid
    # Returns a two digit string indicating the language.
    attr_reader :language
    # Returns a string with the series name for the language indicated
    attr_reader :seriesname
    # An array of alias names if the series has any other names in that language. Empty, if none are listed.
    attr_reader :aliasnames
    # The relative path to the highest rated banner for this series. Retrieve #bannerpath_full get the absolute path.
    attr_reader :bannerpath_relative
    # Returns the overview for the series
    attr_reader :overview
    # The first aired date for the series as a Date instance.
    attr_reader :firstaired
    # Returns the IMDB id for the series if known. Otherwise, +nil+.
    attr_reader :imdb_id
    # Returns the zap2it ID if known. Otherwise, +nil+.
    attr_reader :zap2it_id
    # Returns the Network name if known; Otherwise, +nil+.
    attr_reader :network
    # The full path for the highest rated banner for the series, returned as a URI instance.
    attr_reader :bannerpath_full

    # Initializes a new Search Series Record as is was retrieved from the TheTvDb API
    # Parameters::
    #   +client+::      The TheTvDbParty::Client instance that retrieved the record
    #   +hashValues+::  A Hash{String => String} instance that maps the record attribute element names against their values represented as strings.
    def initialize(client, hashValues)
      @client = client
      @hashValues = hashValues

      read_hash_values
    end

    # Retrieves the Base Series Record for the series
    # Return::    A TheTvDbParty::BaseSeriesRecord instance that represents the series; or +nil+, if the record could not be retrieved.
    # See Also::  TheTvDbParty::Client#get_base_series_record
    def get_base_series_record
      @client.get_base_series_record @seriesid
    end

    private
    def read_hash_values
      def client; @client end
      def id; @hashValues["id"] ? @hashValues["id"].to_i : -1 end
      def seriesid; @hashValues["seriesid"] ? @hashValues["seriesid"].to_i : -1 end
      def language; @hashValues["language"] end
      def seriesname; @hashValues["SeriesName"] end
      def aliasnames; @hashValues["AliasNames"] ? @hashValues["AliasNames"].split('|').reject { |a| a.nil? || a.empty? } : [] end
      def bannerpath_relative; @hashValues["banner"] end
      def overview; @hashValues["Overview"] end
      def firstaired; @hashValues["FirstAired"] ? Date.parse(@hashValues["FirstAired"]) : nil end
      def imdb_id; @hashValues["IMDB_ID"] end
      def zap2it_id; @hashValues["zap2it_id"] end
      def network; @hashValues["Network"] end
      def bannerpath_full; bannerpath_relative ? URI::join(BASE_URL, "banners/", bannerpath_relative) : nil end

      nil
    end
  end
end
