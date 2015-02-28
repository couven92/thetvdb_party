module TheTvDbParty
  class FullSeriesRecord < BaseSeriesRecord

    attr_reader :episodes

    def initialize(client, hashValues)
      super client, hashValues["Series"]

      episodesHashValue = hashValues["Episode"]
      case episodesHashValue
        when Array
          @episodes = episodesHashValue.map { |episodeHashValues| BaseEpisodeRecord.new client, episodeHashValues }
        when Hash
          @episodes = [ BaseEpisodeRecord.new(client, episodesHashValue) ]
        else
          @episodes = []
      end
    end
  end
end
