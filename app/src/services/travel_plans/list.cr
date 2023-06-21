require "../../models/travel_plan"

module TravelPlans
  class ListTravelPlan
    def initialize
    end

    def execute
      TravelPlan.all
    end
  end
end
