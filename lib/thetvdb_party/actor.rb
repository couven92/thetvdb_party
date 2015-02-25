module TheTvDbParty
  # Actors holds information about actors
  # See also:: http://thetvdb.com/wiki/index.php/API:actors.xml
  class Actor
    # The client that was used to get this actor
    attr_reader :client
    # Useless field, will eventually be used to link actors between series but currently isn't in use and may actually change once it gets fully implemented so don't bother storing it at all.
    attr_reader :id
    # Can be appended to <mirrorpath>/banners/ to determine the actual location of the artwork.
    attr_reader :image_path_relative
    # The actors real name.
    attr_reader :name
    # The name of the actors character in the series.
    attr_reader :role
    # An integer from 0-3. 1 being the most important actor on the show and 3 being the third most important actor. 0 means they have no special sort order. Duplicates of 1-3 aren't suppose to be allowed but currently are so the field isn't perfect but can still be used for basic sorting.
    attr_reader :sort_order

    # Initializes a new Actor as it was retrieved from a given client.
    # Parameters::
    #   +client+::      The TheTvDbParty::Client instance that retrieved the record this actor belongs to.
    #   +hashValues+::  A Hash{String => String} instance that maps the actor element names to their string values.
    def initialize(client, hashValues)
      @client = client
      @hashValues = hashValues

      read_hash_values
    end

    def image_path_full
      if @image_path_relative
        return (URI::join(BASE_URL, "banners/", @image_path_relative))
      end
    end

    private
    def read_hash_values
      @id = @hashValues["id"]
      @image_path_relative = @hashValues["Image"]
      @name = @hashValues["Name"]
      @role = @hashValues["Role"]
      sort_order = (default @hashValues["SortOrder"], 0).to_i
      sort_order = sort_order>=0 && sort_order <=3 ? sort_order : 0
      @sort_order = sort_order

      nil
    end
    
    def default value, default
      return value ? value : default
    end
  end
end