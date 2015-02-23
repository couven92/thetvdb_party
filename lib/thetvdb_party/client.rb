module TheTvDbParty
  # The TheTvDb API client
  #
  # Remarks:: If +nil+ is specified for #apikey, the client will not be able to access the API successfully for most functions
  #
  #           The #search method will always be available, even if you do not have a valid API key.
  # Example:: How to use a client to search for a series, and how to get its Base Series Record:: Creates a new client an searches for "The Mentalist"
  #               client = TheTvDbParty::Client.new "<myTheTvDbApiKey>"
  #               searchResults = client.search "The Mentalist"
  #               searchResults.each do |search_result_record|
  #                 base_series_record = search_result_record.get_base_series_record
  #               end
  class Client
    include HTTParty

    # The API key that is currently in use
    attr_accessor :apikey

    # Accesses the language currently used by the client when accessing the TheTvDb API.
    attr_accessor :language

    @language = nil

    # Creates a new TheTvDb client with the given API key
    # apikey::  The API key to use when accessing the ThTvDb programmers API
    def initialize(apikey)
      @apikey = apikey
    end

    # Alias for #search
    def get_series(seriesname) search seriesname end

    # This interface allows you to find the id of a series based on its name.
    # Parameters::
    #   +seriesname+::  This is the string you want to search for. If there is an exact match for the parameter, it will be the first result returned.
    # Returns::     An array of TheTvDbParty::SearchSeriesRecord instances that represent the search results. Empty if the search does not return any matches.
    # Remarks::     The method call with the account identifier is currently not supported.
    # See Also::    http://thetvdb.com/wiki/index.php?title=API:GetSeries
    def search(seriesname)
      http_query = { :seriesname => seriesname }
      http_query[:language] = @language if @language
      response = self.class.get(URI::join(BASE_URL, 'api/', 'GetSeries.php'), { :query => http_query }).parsed_response
      return [] unless response["Data"]
      case response["Data"]["Series"]
        when Array
          response["Data"]["Series"].map {|s|SearchSeriesRecord.new(self, s)}
        when Hash
          [SearchSeriesRecord.new(self, response["Data"]["Series"])]
        else
          []
      end
    end

    # Retrieves the Base Series Record for a given series by its series id.
    # Parameters::
    #   +seriesid+::  The TheTvDb assigned unique identifier for the series to access.
    # Returns::   A TheTvDbParty::BaseSeriesRecord instance or +nil+ if the series could not be found.
    def get_base_series_record(seriesid)
      unless @language
        request_url = "#{@apikey}/series/#{seriesid}"
      else
        request_url = "#{@apikey}/series/#{seriesid}/#{@language}.xml"
      end
      request_url = URI.join(BASE_URL, 'api/', request_url)
      resp = self.class.get(request_url).parsed_response
      return nil unless resp["Data"]
      return nil unless resp["Data"]["Series"]
      BaseSeriesRecord.new(self, resp["Data"]["Series"])
    end

    # Retrieves the base episode record for an episode by its TheTvDb unique identifier
    # Parameters::
    #   +episodeid+:: The unique episode identifier of the episode to access
    # Returns:: A TheTvDbParty::BaseEpisodeRecord instance representing the episode, or +nil+ if the record was not found.
    def get_base_episode_record(episodeid)
      unless @language
        request_url = "#{@apikey}/episodes/#{episodeid}"
      else
        request_url = "#{@apikey}/episodes/#{episodeid}/#{@language}.xml"
      end
      request_url = URI::join(BASE_URL, 'api/', request_url)
      get_base_episode_record_from_url request_url
    end

    # Retrieves the base episode record for an episode by its default ordering in a series.
    # Parameters::
    #   +seriesid+::        The TheTvDb unique identifier for the series to which the episode belongs.
    #   +season_number+::   The number of the season in which the episode appeared.
    #   +episode_number+::  The episode number within the season
    # Returns::     A TheTvDbParty::BaseEpisodeRecord instance representing the episode or +nil+ if the record was not found.
    # Remarks::     Specials episodes are ordered within season +0+. Attributes within the returned record indicate at which time (i.e. between which episode the episode should be ordered)
    # See Also::    #get_series_dvd_season_episode, #get_series_absolute_episode, #get_base_episode_record
    def get_series_season_episode(seriesid, season_number, episode_number)
      unless @language
        request_url = "#{@apikey}/series/#{seriesid}/default/#{season_number}/#{episode_number}"
      else
        request_url = "#{@apikey}/series/#{seriesid}/default/#{season_number}/#{episode_number}/#{@language}.xml"
      end
      request_url = URI.join(BASE_URL, 'api/', request_url)
      get_base_episode_record_from_url request_url
    end

    # Retrieves the base episode record for an episode by its DVD ordering in a series.
    # Parameters::
    #   +seriesid+::        The TheTvDb unique identifier for the series to which the episode belongs.
    #   +season_number+::   The number of the season in which the episode appeared.
    #   +episode_number+::  The episode number within the season
    # Returns::     A TheTvDbParty::BaseEpisodeRecord instance representing the episode or +nil+ if the record was not found.
    # Remarks::     Specials episodes are ordered within season +0+. Attributes within the returned record indicate at which time (i.e. between which episode the episode should be ordered)
    # See Also::    #get_series_season_episode, #get_series_absolute_episode, #get_base_episode_record
    def get_series_dvd_season_episode(seriesid, season_number, episode_number)
      unless @language
        request_url = "#{@apikey}/series/#{seriesid}/dvd/#{season_number}/#{episode_number}"
      else
        request_url = "#{@apikey}/series/#{seriesid}/dvd/#{season_number}/#{episode_number}/#{@language}.xml"
      end
      request_url = URI.join(BASE_URL, 'api/', request_url)
      get_base_episode_record_from_url request_url
    end

    # Retrieves the base episode record for an episode by its absolute ordering in a series.
    # Parameters::
    #   +seriesid+::        The TheTvDb unique identifier for the series to which the episode belongs.
    #   +episode_number+::  The absolute episode number within the series
    # Returns::     A TheTvDbParty::BaseEpisodeRecord instance representing the episode or +nil+ if the record was not found.
    # Remarks::     Specials episodes are ordered within season +0+. Attributes within the returned record indicate at which time (i.e. between which episode the episode should be ordered)
    # See Also::    #get_series_season_episode, #get_series_dvd_season_episode, #get_base_episode_record
    def get_series_absolute_episode(seriesid, episode_number)
      unless @language
        request_url = "#{@apikey}/series/#{seriesid}/absolute/#{episode_number}"
      else
        request_url = "#{@apikey}/series/#{seriesid}/absolute/#{episode_number}/#{@language}.xml"
      end
      request_url = URI.join(BASE_URL, 'api/', request_url)
      get_base_episode_record_from_url request_url
    end

    # Retrieves the banners for a given series by its series id.
    # Parameters::
    #   +seriesid+::  The TheTvDb assigned unique identifier for the series to access.
    # Returns::   An array of TheTvDbParty::Banner instances or +nil+ if the banners could not be retrieved. Note: may return [] if banners are retrieved but there are none.
    def get_series_banners(seriesid)
      request_url = "#{@apikey}/series/#{seriesid}/banners.xml"
      request_url = URI.join(BASE_URL, 'api/', request_url)
      response = self.class.get(request_url).parsed_response
      return nil unless response["Banners"]
      return nil unless response["Banners"]["Banner"]
      case response["Banners"]["Banner"]
        when Array
          response["Banners"]["Banner"].map {|s|Banner.new(self, s)}
        when Hash
          [Banner.new(self, response["Banners"]["Banner"])]
        else
          []
      end
    end

    # Retrieves the actors for a given series by its series id.
    # Parameters::
    #   +seriesid+::  The TheTvDb assigned unique identifier for the series to access.
    # Returns::   An array of TheTvDbParty::Actor instances or +nil+ if the actors could not be retrieved. Note: may return [] if actors are retrieved but there are none.
    def get_series_actors(seriesid)
      request_url = "#{@apikey}/series/#{seriesid}/actors.xml"
      request_url = URI.join(BASE_URL, 'api/', request_url)
      response = self.class.get(request_url).parsed_response
      return nil unless response["Actors"]
      return nil unless response["Actors"]["Actor"]
      case response["Actors"]["Actor"]
        when Array
          response["Actors"]["Actor"].map {|s|Actor.new(self, s)}
        when Hash
          [Actor.new(self, response["Actors"]["Actor"])]
        else
          []
      end
    end

    private
    def get_base_episode_record_from_url(request_url)
      resp = self.class.get(request_url).parsed_response
      return nil unless resp["Episode"]
      BaseEpisodeRecord.new(self, resp["Episode"])
    end
  end
end

