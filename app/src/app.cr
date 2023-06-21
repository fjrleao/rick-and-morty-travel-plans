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

  get "/travel_plans" do |env|
    env.response.content_type = "application/json"
    TravelPlan.all.to_json
  end

  get "/travel_plans/:id" do |env|
    id = env.params.url["id"]
    env.response.content_type = "application/json"
    env.response.status_code = 200
    TravelPlan.find(id).to_json
  end

  delete "/travel_plans/:id" do |env|
    id = env.params.url["id"]
    TravelPlan.delete(id)
    env.response.status_code = 204
  end
end

Kemal.run
