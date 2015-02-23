module TheTvDbParty
  # Actors holds information about actors
  # See also:: http://thetvdb.com/wiki/index.php/API:actors.xml
  class Actor
    # Useless field, will eventually be used to link actors between series but currently isn't in use and may actually change once it gets fully implemented so don't bother storing it at all.
    attr_reader :id
    # Can be appended to <mirrorpath>/banners/ to determine the actual location of the artwork.
    attr_reader :image
    # The actors real name.
    attr_reader :name
    # The name of the actors character in the series.
    attr_reader :role
    # An integer from 0-3. 1 being the most important actor on the show and 3 being the third most important actor. 0 means they have no special sort order. Duplicates of 1-3 aren't suppose to be allowed but currently are so the field isn't perfect but can still be used for basic sorting.
    attr_reader :sortOrder

    # Initializes a new Actor as it was retrieved from a given client.
    # Parameters::
    #   +client+::      The TheTvDbParty::Client instance that retrieved the record this actor belongs to.
    #   +hashValues+::  A Hash{String => String} instance that maps the actor element names to their string values.
    def initialize(client, hashValues)
      @client = client
      @hashValues = hashValues

      read_hash_values
    end

    private
    def read_hash_values
      @id = default @hashValues["id"], -1
      @image = @hashValues["Image"]
      @name = @hashValues["Name"]
      @role = @hashValues["Role"]
      @sortOrder = default @hashValues["SortOrder"], 0

      nil
    end
    
    def default value, default
      return value ? value : default
    end
  end
end