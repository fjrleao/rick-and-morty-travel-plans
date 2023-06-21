require "../../models/travel_plan"

module TravelPlans
  class RetrieveTravelPlan
    def initialize(id : Int32)
      @id = id
    end

    def execute(expand, optimize)
      travel_plans = TravelPlan.find!(@id).to_h

      travel_plans_to_return = Hash(String, Array(Hash(String, Int32 | String) | Int32) | Array(Hash(String, Int32 | String)) | Int32).new

      plan = ListTravelPlanSerializable.from_json(travel_plans.to_json.to_s)
      if expand
        travel_stops = Array(Int32).from_json(plan.travel_stops.to_s)
        travel_stops = RickAndMortyApi.locationsById(travel_stops)
      else
        travel_stops = plan.travel_stops
      end
      travel_plans_to_return["id"] = plan.id
      travel_plans_to_return["travel_stops"] = travel_stops

      travel_plans_to_return
    end
  end
end
