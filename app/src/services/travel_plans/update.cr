require "../../models/travel_plan"

module TravelPlans
  class UpdateTravelPlan
    def initialize(id : Int32, travel_stops : Array(Int32))
      @id = id
      @travel_stops = travel_stops
    end

    def execute
      TravelPlan.where { _id == @id }.update(travel_stops: @travel_stops)
      TravelPlan.find!(@id)
    end
  end
end
