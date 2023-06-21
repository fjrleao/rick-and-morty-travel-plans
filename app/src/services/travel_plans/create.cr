require "../../models/travel_plan"

module TravelPlans
  class CreateTravelPlan
    def initialize(travel_stops : Array(Int32))
      @travel_stops = travel_stops
    end

    def execute
      TravelPlan.create(travel_stops: @travel_stops)
    end
  end
end
