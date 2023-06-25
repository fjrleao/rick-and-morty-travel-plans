require "kemal"
require "./models/travel_plan"
require "./controllers/travel_plan_controllers"
require "./config/config"

module App
  VERSION = "0.1.0"

  before_all do |env|
    env.response.content_type = "application/json"
  end

  post "/travel_plans" do |env|
    begin
      body = TravelPlanSerializer.from_json env.request.body.not_nil!
      env.response.status_code = 201
      TravelPlansControllers.create(body.travel_stops).to_json
    rescue exception
      halt env, status_code = 400, %({"message": "#{exception.message.not_nil!.split('\n')[0]}"})
    end
  end

  get "/travel_plans" do |env|
    query = env.params.query.to_h
    TravelPlansControllers.list(query).to_json
  end

  get "/travel_plans/:id" do |env|
    begin
      id = env.params.url["id"]
      query = env.params.query.to_h
      env.response.status_code = 200
      TravelPlansControllers.retrieve(id, query).to_json
    rescue exception
      puts exception
      halt env, status_code = 404, %({"message": "Travel plan not found"})
    end
  end

  delete "/travel_plans/:id" do |env|
    id = env.params.url["id"]
    TravelPlansControllers.delete(id)
    env.response.status_code = 204
  end

  put "/travel_plans/:id" do |env|
    begin
      id = env.params.url["id"]
      body = TravelPlanSerializer.from_json env.request.body.not_nil!
      TravelPlansControllers.update(id, body.travel_stops).to_json
    rescue exception
      if exception.message.not_nil!.includes?("Missing JSON attribute")
        status_code = 400
        message = %({"message": "#{exception.message.not_nil!.split('\n')[0]}"})
      else
        status_code = 404
        message = %({"message": "Travel plan not found"})
      end
      halt env, status_code, message
    end
  end

  patch "/travel_plans/:id/append" do |env|
    begin
      id = env.params.url["id"]
      body = TravelPlanSerializer.from_json env.request.body.not_nil!
      TravelPlansControllers.append(id, body.travel_stops).to_json
    rescue exception
      if exception.message.not_nil!.includes?("Missing JSON attribute")
        status_code = 400
        message = %({"message": "#{exception.message.not_nil!.split('\n')[0]}"})
      else
        status_code = 404
        message = %({"message": "Travel plan not found"})
      end
      halt env, status_code, message
    end
  end

  get "/docs" do |env|
    env.response.content_type = "text/html"
    render "src/public/docs/index.ecr"
  end
end

Kemal.run
