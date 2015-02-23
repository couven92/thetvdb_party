module TheTvDbParty
  # Banner holds information about banners associated with series and seasons.
  # See Also::  http://thetvdb.com/wiki/index.php/API:banners.xml
  class Banner
  	# Unique ID for this banner
  	attr_reader :id
    # Can be appended to <mirrorpath>/banners/ to determine the actual location of the artwork.
    attr_reader :bannerPath
    # Used exactly the same way as BannerPath, only shows if BannerType is fanart.
    attr_reader :thumbnailPath
    attr_reader :vignettePath
    # This can be poster, fanart, series or season.
    attr_reader :bannerType
    # For series banners it can be text, graphical, or blank. For season banners it can be season or seasonwide. For fanart it can be 1280x720 or 1920x1080. For poster it will always be 680x1000.
    # Blank banners will leave the title and show logo off the banner. Text banners will show the series name as plain text in an Arial font. Graphical banners will show the series name in the show's official font or will display the actual logo for the show. Season banners are the standard DVD cover format while wide season banners will be the same dimensions as the series banners.
    attr_reader :bannerType2
    # Some banners list the series name in a foreign language. The language abbreviation will be listed here.
    attr_reader :language
    # If the banner is for a specific season.
    attr_reader :season
    # Either nil or a decimal with four decimal places. The rating the banner currently has on the site.
    attr_reader :rating
    # Always returns an unsigned integer. Number of people who have rated the image.
    attr_reader :ratingCount
    # This can be true or false. Only shows if BannerType is fanart. Indicates if the seriesname is included in the image or not.
    attr_reader :seriesName
    # Returns either nil or an array of three RGB colors. These are colors the artist picked that go well with the image. In order they are Light Accent Color, Dark Accent Color and Neutral Midtone Color. It's meant to be used if you want to write something over the image, it gives you a good idea of what colors may work and show up well. Only shows if BannerType is fanart.
    attr_reader :colors

    # Initializes a new Banner as it was retrieved from a given client.
    # Parameters::
    #   +client+::      The TheTvDbParty::Client instance that retrieved the record this banner belongs to.
    #   +hashValues+::  A Hash{String => String} instance that maps the banner element names to their string values.
    def initialize(client, hashValues)
      @client = client
      @hashValues = hashValues

      read_hash_values
    end

    private
    def read_hash_values
    	@bannerPath = @hashValues["BannerPath"]
	    @thumbnailPath = @hashValues["ThumbnailPath"]
	    @vignettePath = @hashValues["VignettePath"]
	    @bannerType = @hashValues["BannerType"]
	    @bannerType2 = @hashValues["BannerType2"]
	    @language = @hashValues["Language"]
	    @season = @hashValues["Season"]
	    @rating = @hashValues["Rating"]
	    @ratingCount = @hashValues["RatingCount"] ? @hashValues["RatingCount"] : 0
	    @seriesName = @hashValues["SeriesName"] ? @hashValues["SeriesName"] : false
	    @colors = @hashValues["Colors"]

      nil
    end
  end
end