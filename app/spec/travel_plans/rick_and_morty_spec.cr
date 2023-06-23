require "../spec_helper"

describe RickAndMortyApi do
  context "Rick and Morty API operations" do
    it "Should be capable to get detailed data from Rick and Morty API" do
      rickAndMortyApi = RickAndMortyApi.new

      locations = rickAndMortyApi.locationsById([1])

      locations["locationsByIds"][0]["id"].should eq "1"
    end

    it "Should be capable to convert id from string to integer" do
      rickAndMortyApi = RickAndMortyApi.new

      locations = rickAndMortyApi.convertIdToInteger({
        "locationsByIds" => [
          {
            "id" => "1",
          },
          {
            "id" => "2",
          },
        ],
      })

      locations[0]["id"].should eq 1
      locations[1]["id"].should eq 2
    end

    it "Should be capable to optimize travel" do
      rickAndMortyApi = RickAndMortyApi.new

      optimizedTravel = rickAndMortyApi.optimizeTravel([1, 2])

      optimizedTravel.should eq [2, 1]
    end

    it "Should be capable to expand a optimized travel" do
      rickAndMortyApi = RickAndMortyApi.new

      optimized_array = [2, 1]
      expanded_data = [
        {
          "id"   => 1,
          "name" => "Planeta",
        },
        {
          "id"   => 2,
          "name" => "Planeta",
        },
      ]
      optimizedExpanded = rickAndMortyApi.expandOptimized(optimized_array, expanded_data)
    end
  end
end
