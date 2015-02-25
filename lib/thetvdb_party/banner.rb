module TheTvDbParty
  # Banner holds information about banners associated with series and seasons.
  # See Also::  http://thetvdb.com/wiki/index.php/API:banners.xml
  class Banner
    # The client that was used to get this banner
    attr_reader :client
  	# Unique ID for this banner
  	attr_reader :id
    # Can be appended to <mirrorpath>/banners/ to determine the actual location of the artwork.
    attr_reader :banner_path_relative
    # Used exactly the same way as BannerPath, only shows if BannerType is fanart.
    attr_reader :thumbnail_path_relative
    attr_reader :vignette_path_relative
    # This can be poster, fanart, series or season.
    attr_reader :banner_type
    # For series banners it can be text, graphical, or blank. For season banners it can be season or seasonwide. For fanart it can be 1280x720 or 1920x1080. For poster it will always be 680x1000.
    # Blank banners will leave the title and show logo off the banner. Text banners will show the series name as plain text in an Arial font. Graphical banners will show the series name in the show's official font or will display the actual logo for the show. Season banners are the standard DVD cover format while wide season banners will be the same dimensions as the series banners.
    attr_reader :banner_type_2
    # Some banners list the series name in a foreign language. The language abbreviation will be listed here.
    attr_reader :language
    # If the banner is for a specific season.
    attr_reader :season
    # Either nil or a decimal with four decimal places. The rating the banner currently has on the site.
    attr_reader :rating
    # Always returns an unsigned integer. Number of people who have rated the image.
    attr_reader :rating_count
    # This can be true or false. Only shows if BannerType is fanart. Indicates if the seriesname is included in the image or not.
    attr_reader :series_name
    # Returns either nil or a RGB color. These are colors the artist picked that go well with the image. It's meant to be used if you want to write something over the image, it gives you a good idea of what colors may work and show up well. Only shows if BannerType is fanart.
    attr_reader :light_accent_color
    # Returns either nil or a RGB color. These are colors the artist picked that go well with the image. It's meant to be used if you want to write something over the image, it gives you a good idea of what colors may work and show up well. Only shows if BannerType is fanart.
    attr_reader :dark_accent_color
    # Returns either nil or a RGB color. These are colors the artist picked that go well with the image. It's meant to be used if you want to write something over the image, it gives you a good idea of what colors may work and show up well. Only shows if BannerType is fanart.
    attr_reader :neutral_midtone_color

    # Initializes a new Banner as it was retrieved from a given client.
    # Parameters::
    #   +client+::      The TheTvDbParty::Client instance that retrieved the record this banner belongs to.
    #   +hashValues+::  A Hash{String => String} instance that maps the banner element names to their string values.
    def initialize(client, hashValues)
      @client = client
      @hashValues = hashValues

      read_hash_values
    end

    def banner_path_full
      if @banner_path_relative
        return (URI::join(BASE_URL, "banners/", @banner_path_relative))
      end
    end

    def thumbnail_path_full
      if @thumbnail_path_relative
        return (URI::join(BASE_URL, "banners/", @thumbnail_path_relative))
      end
    end

    def vignette_path_full
      if @vignette_path_relative
        return (URI::join(BASE_URL, "banners/", @vignette_path_relative))
      end
    end

    private
    def read_hash_values
      @id = @hashValues["id"]
    	@banner_path_relative = @hashValues["BannerPath"]
	    @thumbnail_path_relative = @hashValues["ThumbnailPath"]
	    @vignette_path_relative = @hashValues["VignettePath"]
      banner_type = @hashValues["BannerType"] ? (@hashValues["BannerType"].downcase) : nil
      if ["poster", "fanart", "series", "season"].include? banner_type
        @banner_type = banner_type
        banner_type_2 = @hashValues["BannerType2"] ? (@hashValues["BannerType2"].downcase) : nil
        case banner_type
        when "series"
          validValues = ["text", "graphical", "blank"]
        when "season"
          validValues = ["season", "seasonwide"]
        when "fanart"
          validValues = ["1280x720", "1920x1080"]
        when "poster"
          validValues = ["680x1000"]
        else
          validValues = []
        end
        if validValues.include? banner_type_2
          @banner_type_2 = banner_type_2
        else
          @banner_type_2 = nil
        end
      else
        @banner_type = nil
        @banner_type_2 = nil
      end
	    @language = @hashValues["Language"]
	    @season = @hashValues["Season"] ? @hashValues["Season"].to_i : nil
	    @rating = @hashValues["Rating"] ? @hashValues["Rating"].to_f : 0.to_f
	    @rating_count = @hashValues["RatingCount"] ? @hashValues["RatingCount"].to_i : 0
      if banner_type == "fanart"
	      @series_name = @hashValues["SeriesName"] ? (@hashValues["SeriesName"]=="true" ? true : false) : false
      else
        @series_name = false
      end
      if @hashValues["Colors"] && banner_type == "fanart"
        colors = (@hashValues["Colors"].split "|")[1..3]
        if colors.length==3
          @light_accent_color = (colors[0].split ",").collect{|x| x.to_i}
          for value in @light_accent_color
            if value == nil || value <0 || value >255
              @light_accent_color = nil
            end
          end
          @dark_accent_color = (colors[1].split ",").collect{|x| x.to_i}
          for value in @dark_accent_color
            if value == nil || value <0 || value >255
              @dark_accent_color = nil
            end
          end
          @neutral_midtone_color = (colors[2].split ",").collect{|x| x.to_i}
          for value in @neutral_midtone_color
            if value == nil || value <0 || value >255
              @neutral_midtone_color = nil
            end
          end
          if @light_accent_color.length!=3 || @dark_accent_color.length!=3 || @neutral_midtone_color.length!=3
            @light_accent_color = nil
            @dark_accent_color = nil
            @neutral_midtone_color = nil
          end
        end
      end
      nil
    end

    def default value, default
      return value ? value : default
    end
  end
end