require "../models/travel_plan"
require "../services/travel_plans/*"

class TravelPlansControllers
  def self.create(travel_stops)
    TravelPlans::CreateTravelPlan.new(travel_stops).execute
  end

  def self.list(query)
    optimize = false
    expand = false

    if query.has_key?("optimize")
      optimize = query["optimize"].to_bool
    end

    if query.has_key?("expand")
      expand = query["expand"].to_bool
    end

    TravelPlans::ListTravelPlan.new.execute(expand, optimize)
  end

  def self.retrieve(id, query)
    optimize = false
    expand = false

    if query.has_key?("optimize")
      optimize = query["optimize"].to_bool
    end

    if query.has_key?("expand")
      expand = query["expand"].to_bool
    end

    TravelPlans::RetrieveTravelPlan.new(id.to_i).execute(expand, optimize)
  end

  def self.delete(id)
    TravelPlans::DeleteTravelPlan.new(id.to_i).execute
  end

  def self.update(id, travel_stops)
    TravelPlans::UpdateTravelPlan.new(id.to_i, travel_stops).execute
  end
end
