ENV["KEMAL_ENV"] = "test"
ENV["BASE_URL_API_RICK_MORTY"] = "https://rickandmortyapi.com/graphql"

require "spec"
require "spec-kemal"
require "../src/app"
