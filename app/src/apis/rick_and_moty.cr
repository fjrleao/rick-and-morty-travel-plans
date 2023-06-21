require "../config/api/api"
require "json"

class RickAndMortyApiSerializable
  include JSON::Serializable

  property locationsByIds : Array(Hash(String, String | Int32))
end

class RickAndMortyApi
  def self.locationsById(filter : Array(Int32))
    data, error, loading = Api::RickAndMorty.new.getApi.query("query locations($ids:[ID!]!){
        locationsByIds(ids: $ids) {
          id,
          name,
          type,
          dimension
        }
      }
    ", {:ids => filter})

    serialized_data = RickAndMortyApiSerializable.from_json(data.to_json.to_s)

    serialized_data.locationsByIds.each do |location|
      location["id"] = location["id"].to_i
    end

    serialized_data.locationsByIds
  end
end
