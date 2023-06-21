require "../../models/travel_plan"

module TravelPlans
  class DeleteTravelPlan
    def initialize(id : Int32)
      @id = id
    end

    def execute
      TravelPlan.delete(@id)
    end
  end
end
