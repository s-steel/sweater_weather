require 'faraday'
require 'json'

class MapquestService
  class << self
    def city_search(city)
      city_response = conn.get('geocoding/v1/address') do |req|
        req.params['location'] = city
      end
      parse_it(city_response)
    end

    def road_trip(from, to)
      trip_response = conn.get('directions/v2/route') do |req|
        req.params['from'] = from
        req.params['to'] = to
      end
      parse_it(trip_response)
    end

    private

    def conn
      Faraday.new('http://www.mapquestapi.com') do |req|
        req.params['key'] = ENV['MAPQUEST_CONSUMER_KEY']
        req.adapter Faraday.default_adapter
      end
    end

    def parse_it(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
