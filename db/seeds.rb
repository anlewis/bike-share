require 'csv'
require './app/models/station'
require './app/models/trip'

class Seed

  OPTIONS = {headers: true, header_converters: :symbol}

  def self.start
    seed_stations
    seed_trips
  end

  def self.seed_stations
    CSV.foreach("./db/csv/station.csv", OPTIONS) do |row|
      row[:installation_date] = Date.strptime(row[:installation_date], "%m/%d/%Y")
      Station.create!(row.to_hash)
    end
  end

  def self.seed_trips
    CSV.foreach("./db/csv/trip.csv", OPTIONS) do |row|
      row[:start_date] = Date.strptime(row[:start_date], "%m/%d/%Y")
      row[:end_date] = Date.strptime(row[:end_date], "%m/%d/%Y")
      Trip.create!(row.to_hash)
    end
  end
end

Seed.start
