require "jennifer"
require "jennifer/adapter/postgres"
require "dotenv"

Dotenv.load

APP_ENV = ENV["APP_ENV"]? || "development"

Jennifer::Config.configure do |conf|
  conf.from_uri(ENV["DATABASE_URI"]) if ENV.has_key?("DATABASE_URI")
  conf.logger.level = :debug
end

Log.setup "db", :debug, Log::IOBackend.new(formatter: Jennifer::Adapter::DBFormatter)
