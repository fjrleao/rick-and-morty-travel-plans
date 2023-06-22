require "../config/api/api"
require "json"

class RickAndMortyApiSerializable
  include JSON::Serializable

  property locationsByIds : Array(Hash(String, String | Int32))
end

class RickAndMortyApi
  def initialize
    private @api = Api::RickAndMorty.new
  end

  def locationsById(filter : Array(Int32), expandResidents = false)
    if expandResidents
      query = "query locations($ids:[ID!]!){
        locationsByIds(ids: $ids) {
          id,
          name,
          type,
          dimension ,
          residents {
            name
            episode {
              id
              name
            }
          }
        }
      }"
    else
      query = "query locations($ids:[ID!]!){
        locationsByIds(ids: $ids) {
          id,
          name,
          type,
          dimension
        }
      }"
    end

    data, error, loading = @api.getApi.query(query, {:ids => filter})

    data
  end

  def convertIdToInteger(data)
    serialized_data = RickAndMortyApiSerializable.from_json(data.to_json.to_s)

    serialized_data.locationsByIds.each do |location|
      location["id"] = location["id"].to_i
    end

    serialized_data.locationsByIds
  end

  def optimizeTravel(filter : Array(Int32))
    data = self.locationsById(filter)
    puts data
  end
end
