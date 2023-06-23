require "../config/api/api"
require "json"

class RickAndMortyApiSerializable
  include JSON::Serializable

  property locationsByIds : Array(Hash(String, String | Int32))
end

class RickAndMortyExpandedApiSerializable
  include JSON::Serializable

  property locationsByIds : Array(Hash(String, String | Array(Hash(String, String | Array(Hash(String, String))))))
end

class RickAndMortyApi
  def initialize
    private @api = Api::RickAndMorty.new
  end

  def locations_by_id(filter : Array(Int32), expand_residents = false)
    if expand_residents
      query = "query locations($ids:[ID!]!){
        locationsByIds(ids: $ids) {
          id,
          name,
          type,
          dimension ,
          residents {
            name,
            episode {
              id
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

  def convert_id_to_integer(data)
    serialized_data = RickAndMortyApiSerializable.from_json(data.to_json.to_s)

    serialized_data.locationsByIds.each do |location|
      location["id"] = location["id"].to_i
    end

    serialized_data.locationsByIds
  end

  def optimize_travel(filter : Array(Int32))
    data = self.locations_by_id(filter, true)

    calculated_data = Array(Hash(String, String | Int32)).new
    dimension_data = Hash(String, Hash(String, Int32)).new
    result_array = Array(Int32).new

    serialized_data = RickAndMortyExpandedApiSerializable.from_json(data.to_json.to_s)
    serialized_data.locationsByIds.each do |location|
      residents_size = location["residents"].size
      idx = 0
      qtd_residents_appeared = 0
      while idx < residents_size
        residents = Hash(String, String | Array(Hash(String, String))).from_json(location["residents"][idx].to_json.to_s)
        qtd_residents_appeared += residents["episode"].size
        idx += 1
      end

      calculated_data.push({
        "location_id"         => location["id"].to_s.to_i,
        "location_name"       => location["name"].to_s,
        "location_popularity" => qtd_residents_appeared,
        "dimension_name"      => location["dimension"].to_s,
      })
    end

    calculated_data.each do |calculated|
      if dimension_data.has_key?(calculated["dimension_name"].to_s)
        dimension_data[calculated["dimension_name"].to_s] = {
          "appeared"         => dimension_data[calculated["dimension_name"].to_s]["appeared"] += 1,
          "total_popularity" => dimension_data[calculated["dimension_name"].to_s]["total_popularity"] += calculated["location_popularity"].to_i,
        }
      else
        dimension_data[calculated["dimension_name"].to_s] = {
          "appeared"         => 1,
          "total_popularity" => calculated["location_popularity"].to_i,
        }
      end
    end

    calculated_data.each do |calculated|
      calculated["dimension_popularity"] = (dimension_data[calculated["dimension_name"].to_s]["total_popularity"] / dimension_data[calculated["dimension_name"].to_s]["appeared"]).to_i
    end

    sorted_data = calculated_data.sort_by { |hsh| [hsh["dimension_popularity"].to_i, hsh["location_popularity"].to_i] }

    sorted_data = sorted_data.sort do |a, b|
      if a["location_popularity"].to_i == b["location_popularity"].to_i
        a["name"].to_s <=> b["name"].to_s
      else
        a["dimension_popularity"].to_i <=> b["dimension_popularity"].to_i
      end
    end

    sorted_data.each do |data|
      result_array.push(data["location_id"].to_i)
    end

    result_array
  end

  def expand_optimized(optimized_array, expanded_data)
    result_hash = Array(Hash(String, String | Int32)).new
    # puts optimized_array
    # puts expanded_data
    optimized_array.each do |id|
      expanded_data.each do |data|
        if data["id"] == id
          result_hash.push(data)
        end
      end
    end
    result_hash
  end
end
