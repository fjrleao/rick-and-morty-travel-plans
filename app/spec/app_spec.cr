require "./spec_helper"

describe App do
  context "POST /travel_plans" do
    it "Should be capable to store a travel_plan" do
      body = {"travel_stops": [2, 7, 9, 11, 19]}

      post "/travel_plans", body: body.to_json

      json = JSON.parse(response.body)
      json["travel_stops"].should eq [2, 7, 9, 11, 19]
    end
  end
end
