require "kemal"
require "./models/travel_plan"
require "./controllers/travel_plan_controllers"
require "./config/config"

module App
  VERSION = "0.1.0"

  post "/travel_plans" do |env|
    body = TravelPlanSerializer.from_json env.request.body.not_nil!
    env.response.content_type = "application/json"
    env.response.status_code = 201
    TravelPlansControllers.create(body.travel_stops).to_json
  end

  get "/travel_plans" do |env|
    env.response.content_type = "application/json"
    TravelPlansControllers.list.to_json
  end

  get "/travel_plans/:id" do |env|
    id = env.params.url["id"]
    env.response.content_type = "application/json"
    env.response.status_code = 200
    TravelPlansControllers.retrieve(id).to_json
  end

  delete "/travel_plans/:id" do |env|
    id = env.params.url["id"]
    TravelPlansControllers.delete(id)
    env.response.status_code = 204
  end

  put "/travel_plans/:id" do |env|
    id = env.params.url["id"]
    body = TravelPlanSerializer.from_json env.request.body.not_nil!
    env.response.content_type = "application/json"
    TravelPlansControllers.update(id, body.travel_stops).to_json
  end
end

Kemal.run
