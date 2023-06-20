require "kemal"
require "./models/travel_plan"
require "./config/config"

module App
  VERSION = "0.1.0"

  post "/travel_plans" do |env|
    body = TravelPlanSerializer.from_json env.request.body.not_nil!
    env.response.content_type = "application/json"
    TravelPlan.create(travel_stops: body.travel_stops).to_json
  end
end

Kemal.run
