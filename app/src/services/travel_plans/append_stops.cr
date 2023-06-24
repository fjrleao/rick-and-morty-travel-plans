require "../../models/travel_plan"

module TravelPlans
  class AppendTravelStop
    def initialize(id : Int32, travel_stops : Array(Int32))
      @id = id
      @travel_stops = travel_stops
    end

    def execute
      travel_plan = TravelPlan.find!(@id)
      travel_stops = @travel_stops.concat(travel_plan.travel_stops).uniq.sort
      travel_plan.travel_stops = travel_stops
      travel_plan.save
      travel_plan
    end
  end
end
