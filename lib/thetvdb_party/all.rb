module TheTvDbParty
  class AllSeriesInformation

    attr_reader :client, :actors, :banners, :full_series_record

    def initialize(client, zip_buffer)
      @client = client

      unzip_file(zip_buffer)

    end

    private
    def unzip_file(zip_buffer)
      @actors = []
      
      zip_file = Zip::InputStream.open(StringIO.new(zip_buffer))

      while entry = zip_file.get_next_entry
        case entry.name
          when "actors.xml"
            actors_hash = MultiXml.parse(entry.get_input_stream.read)

            actors_hash["Actors"]["Actor"].each do |a|
              actors << Actor.new(@client, a)
            end if actors_hash["Actors"]
          when "banners.xml"
            banners_hash = MultiXml.parse(entry.get_input_stream.read)
            case banners_hash["Banners"]["Banner"]
              when Array
                @banners = banners_hash["Banners"]["Banner"].map {|s|Banner.new(self, s)}
              when Hash
                @banners = [Banner.new(self, banners_hash["Banners"]["Banner"])]
              else
                @banners = []
            end if banners_hash && banners_hash["Banners"]
          else
            full_hash = MultiXml.parse(entry.get_input_stream.read)
            @full_series_record = FullSeriesRecord.new(@client, full_hash["Data"])
        end
      end
    end
  end
end
