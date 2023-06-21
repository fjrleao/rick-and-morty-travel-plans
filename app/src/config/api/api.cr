require "crystal-gql"
require "dotenv"

Dotenv.load

module Api
  class RickAndMorty
    def initialize
      private @api = GraphQLClient.new ENV["BASE_URL_API_RICK_MORTY"]
    end

    def getApi
      @api
    end
  end
end
