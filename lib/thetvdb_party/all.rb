module TheTvDbParty

  attr_reader :actors, :banners, :series, :episodes

  class AllSeriesInformation

    def initialize(client, zip_file)
      @client = client

      unzip_file(zip_file)

    end


  private

  def unzip_file(zip_file)
    zip_file.glob("Actors").each do |actor|
      @actors.insert Actor.new(@client, actor.input_stream.read)
    end

    zip_file.glob("Banners").each do |banner|
      @banners.insert Banner.new(@client, banner.input_stream.read)
    end

    @series = BaseSeriesRectord.new(@client, zip_file.glob("Series").input_stream.read)

    zip_file.glob("Episode").each do |episode|
      @episodes.insert Episode.new(@client, episode.input_stream.read)
    end

  end


end