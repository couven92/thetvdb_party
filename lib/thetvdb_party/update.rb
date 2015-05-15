module TheTvDbParty
  # TheTvDB updates
  
  #Struct.new("SerieUpdate",:seriesid,:updatetime)
  #Struct.new("EpisodeUpdate",:episodeid,:seriesid,:updatetime)
  #Struct.new("BannerUpdate",:path,:format,:type,:seriesid,:seasonnum,:language)
  
  class Update
      # TheTvDB client used
      attr_reader :client
      # The timestamp from TheTvDB when the update was handled. To be used for update chaining and verificaton.
      attr_reader :timestamp
      # The list of seriesids for shows which has been updated
      attr_reader :series
      # The list of episodeids for episodes which has been updated
      attr_reader :episodes
      # The list of bannerids for banners which has been updated
      attr_reader :banners
    
    def initialize(client, data, ziped)
      @client = client
      
      if(ziped==true)
        read_ziped_values(data)
      else
        read_hash_values(data)
      end
    end
    
    private
    def read_ziped_values(zip_buffer)
      zip_file = Zip::InputStream.open(StringIO.new(zip_buffer))

      # The zip files only consists of a single file
      entry = zip_file.get_next_entry
      full_hash = MultiXml.parse(entry.get_input_stream.read)
      read_hash_values(full_hash)
    end
    
    def read_hash_values(hash)
      if hash["Data"]
        data = hash["Data"]
        @timestamp = data["time"] #Change to Time.new(data["time"])?
        if(data["Series"])
          @series = Array.new
          for serie in data["Series"]
            #@series.push(Struct::SerieUpdate.new(serie["id"],serie["time"]))
            @series.push({:seriesid=>serie["id"],:updatetime=>serie["time"]})
          end
        end
        if(data["Episode"])
          @episodes = Array.new
          for episode in data["Episode"]
            #@episodes.push(Struct::EpisodeUpdate.new(episode["id"],episode["Series"],episode["time"]))
            @episodes.push({:episodeid=>episode["id"],:seriesid=>episode["Series"],:updatetime=>episode["time"]})
          end
        end
        if(data["Banner"])
          @banners = Array.new
          for banner in data["Banner"]
            #@banners.push(Struct::BannerUpdate.new(banner["path"],banner["format"],banner["type"],banner["Series"],banner["SeasonNum"],banner["language"],banner["time"]))
            @banners.push({:path=>banner["path"],:format=>banner["format"],:type=>banner["type"],:seriesid=>banner["Series"],:seasonnum=>banner["SeasonNum"],:language=>banner["language"],:updatetime=>banner["time"]})
          end
        end
      end
      if hash["Items"]
        items = hash["Items"]
        @timestamp = items["Time"]
        if items["Series"]
          @series = Array.new
          for serie in items["Series"]
            #@series.push(Struct::SerieUpdate.new(serie,nil))
            @series.push({:seriesid=>serie,:updatetime=>nil})
          end
        end
        if items["Episode"]
          @episodes = Array.new
          for episode in items["Episode"]
            #@episodes.push(Struct::EpisodeUpdate.new(episode,nil,nil))
            @episodes.push({:episodeid=>episode,:seriesid=>nil,:updatetime=>nil})
          end
        end
      end
    end
    
  end
end