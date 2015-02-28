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
      @banners = []

      zip_file = Zip::InputStream.open(StringIO.new(zip_buffer))

      while entry = zip_file.get_next_entry
        case entry.name
          when "en.xml"
            full_hash = MultiXml.parse(entry.get_input_stream.read)
            @full_series_record = FullSeriesRecord.new(@client, full_hash["Data"])
          when "actors.xml"
            actors_hash = MultiXml.parse(entry.get_input_stream.read)

            actors_hash["Actors"]["Actor"].each do |a|
              actors << Actor.new(@client, a)
            end if actors_hash["Actors"]
          when "banners.xml"
            banners_hash = MultiXml.parse(entry.get_input_stream.read)
            banners_hash["Banners"]["Banner"].each do |b|
              banners << Banner.new(@client, b)
            end if banners_hash["Banners"]
        end
      end
    end
  end
end
