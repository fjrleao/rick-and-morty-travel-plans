require "../../models/travel_plan"

module TravelPlans
  class RetrieveTravelPlan
    def initialize(id : Int32)
      @id = id
    end

    def execute
      TravelPlan.find(@id)
    end
  end
end
