module TheTvDbParty
  class AllSeriesInformation

    attr_reader :client, :actors, :banners, :series, :episodes

    def initialize(client, zip_buffer)
      @client = client

      unzip_file(zip_buffer)

    end

    private
    def unzip_file(zip_buffer)
      @actors = []
      @banners = []
      @episodes = []

      zip_file = Zip::InputStream.open(StringIO.new(zip_buffer))

      while entry = zip_file.get_next_entry
        case entry.name
          when "en.xml"
            # @series = BaseSeriesRecord.new(@client, entry.read)
            # @episodes << Episode.new(@client, entry.read)
          when "actors.xml"
            @actors << Actor.new(@client, entry.read)
          when "banners.xml"
            @banners << Banner.new(@client, entry.read)
          else
            puts entry.name
        end
      end
    end
  end
end
