require "../../models/travel_plan"
require "../../apis/rick_and_moty"
require "json"

class ListTravelPlanSerializable
  include JSON::Serializable

  property id : Int32
  property travel_stops : Array(Int32 | Hash(String, String | Int32))
end

module TravelPlans
  class ListTravelPlan
    def initialize
    end

    def execute(expand, optimize)
      travel_plans = TravelPlan.all.to_a

      rickAndMortyApi = RickAndMortyApi.new

      if expand && optimize
        travel_plans_to_return = [] of Hash(String, Array(Hash(String, Int32 | String)) | Int32)
        travel_plans.each do |plan|
          plan = ListTravelPlanSerializable.from_json(plan.to_json.to_s)
          travel_stops_array = Array(Int32).from_json(plan.travel_stops.to_s)
          travel_stops = rickAndMortyApi.locations_by_id(travel_stops_array)
          travel_stops = rickAndMortyApi.convert_id_to_integer(travel_stops)
          optimized_array = rickAndMortyApi.optimize_travel(travel_stops_array)
          travel_stops = rickAndMortyApi.expand_optimized(optimized_array, travel_stops)
          travel_plans_to_return.push({
            "id"           => plan.id,
            "travel_stops" => travel_stops,
          })
        end
        return travel_plans_to_return
      end

      if optimize
        travel_plans_to_return = [] of Hash(String, Array(Int32) | Int32)
        travel_plans.each do |plan|
          plan = ListTravelPlanSerializable.from_json(plan.to_json.to_s)
          travel_stops = Array(Int32).from_json(plan.travel_stops.to_s)
          travel_plans_to_return.push({
            "id"           => plan.id,
            "travel_stops" => rickAndMortyApi.optimize_travel(travel_stops),
          })
        end
        return travel_plans_to_return
      end

      if expand
        travel_plans_to_return = [] of Hash(String, Array(Hash(String, Int32 | String)) | Int32)
        travel_plans.each do |plan|
          plan = ListTravelPlanSerializable.from_json(plan.to_json.to_s)
          travel_stops = Array(Int32).from_json(plan.travel_stops.to_s)
          travel_stops = rickAndMortyApi.locations_by_id(travel_stops)
          travel_stops = rickAndMortyApi.convert_id_to_integer(travel_stops)
          travel_plans_to_return.push({
            "id"           => plan.id,
            "travel_stops" => travel_stops,
          })
        end
        return travel_plans_to_return
      end

      travel_plans
    end
  end
end
