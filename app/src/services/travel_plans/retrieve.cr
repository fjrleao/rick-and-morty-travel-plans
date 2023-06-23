require "../../models/travel_plan"

module TravelPlans
  class RetrieveTravelPlan
    def initialize(id : Int32)
      @id = id
    end

    def execute(expand, optimize)
      travel_plans = TravelPlan.find!(@id).to_h
      rickAndMortyApi = RickAndMortyApi.new

      travel_plans_to_return = Hash(String, Array(Hash(String, Int32 | String) | Int32) | Array(Hash(String, Int32 | String)) | Int32).new

      plan = ListTravelPlanSerializable.from_json(travel_plans.to_json.to_s)

      travel_stops_array = Array(Int32).from_json(plan.travel_stops.to_s)

      if expand && optimize
        travel_stops = rickAndMortyApi.locations_by_id(travel_stops_array)
        travel_stops = rickAndMortyApi.convert_id_to_integer(travel_stops)
        optimized_array = rickAndMortyApi.optimize_travel(travel_stops_array)
        travel_stops = rickAndMortyApi.expand_optimized(optimized_array, travel_stops)
        return {
          "id"           => plan.id,
          "travel_stops" => travel_stops,
        }
      end

      if expand
        travel_stops = rickAndMortyApi.locations_by_id(travel_stops_array)
        travel_stops = rickAndMortyApi.convert_id_to_integer(travel_stops)
        return {
          "id"           => plan.id,
          "travel_stops" => travel_stops,
        }
      end

      if optimize
        return {
          "id"           => plan.id,
          "travel_stops" => rickAndMortyApi.optimize_travel(travel_stops_array),
        }
      end

      return {
        "id"           => plan.id,
        "travel_stops" => travel_stops_array,
      }
    end
  end
end
