module TheTvDbParty
  require 'rubyzip'
  class AllSeriesInformation

    attr_reader :actors, :banners, :series, :episodes

    def initialize(client, zip_buffer)
      @client = client

      unzip_file(zip_buffer)

    end

    private
    def unzip_file(zip_buffer)
      @actors = []
      @banners = []
      @episodes = []

      zip_file = Zip::File.open_buffer(zip_buffer)

      @series = BaseSeriesRectord.new(@client, zip_file.glob("Series").input_stream.read)

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
