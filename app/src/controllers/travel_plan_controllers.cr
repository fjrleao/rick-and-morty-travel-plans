require "../models/travel_plan"
require "../services/travel_plans/*"

class TravelPlansControllers
  def self.create(travel_stops)
    TravelPlans::CreateTravelPlan.new(travel_stops).execute
  end

  def self.list
    TravelPlans::ListTravelPlan.new.execute
  end

  def self.retrieve(id)
    TravelPlans::RetrieveTravelPlan.new(id.to_i).execute
  end

  def self.delete(id)
    TravelPlans::DeleteTravelPlan.new(id.to_i).execute
  end

  def self.update(id, travel_stops)
    TravelPlans::UpdateTravelPlan.new(id.to_i, travel_stops).execute
  end
end
