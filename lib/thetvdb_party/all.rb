module TheTvDbParty
  class AllSeriesInformation

    attr_reader :actors, :banners, :series, :episodes
    
    def initialize(client, zip_file)
      @client = client

      unzip_file(zip_file)

    end

    private
    def unzip_file(zip_file)
      @series = BaseSeriesRectord.new(@client, zip_file.glob("Series").input_stream.read)
      @actors = []
      @banners = []
      @episodes = []
  
      zip_file.glob("Actors").each do |actor|
        @actors << Actor.new(@client, actor.input_stream.read)
      end
  
      zip_file.glob("Banners").each do |banner|
        @banners << Banner.new(@client, banner.input_stream.read)
      end
  
      zip_file.glob("Episode").each do |episode|
        @episodes << Episode.new(@client, episode.input_stream.read)
      end
  
    end
  end
end
