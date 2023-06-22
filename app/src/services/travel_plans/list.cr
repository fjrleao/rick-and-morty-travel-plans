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
      travel_plans_to_return = [] of Hash(String, Array(Hash(String, Int32 | String) | Int32) | Array(Hash(String, Int32 | String)) | Int32)

      travel_plans.each do |plan|
        plan = ListTravelPlanSerializable.from_json(plan.to_json.to_s)
        if expand
          travel_stops = Array(Int32).from_json(plan.travel_stops.to_s)
          travel_stops = RickAndMortyApi.new.locationsById(travel_stops)
        else
          travel_stops = plan.travel_stops
        end
        travel_plans_to_return.push({
          "id"           => plan.id,
          "travel_stops" => travel_stops,
        })
      end
      travel_plans_to_return
    end
  end
end
