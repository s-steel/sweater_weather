require 'faraday'
require 'json'

class MapquestService
  class << self
    def city_search(city)
      city_response = conn.get('address') do |req|
        req.params['key'] = ENV['MAPQUEST_CONSUMER_KEY']
        req.params['location'] = city
      end
      parse_it(city_response)
    end

    private

    def conn
      Faraday.new('http://www.mapquestapi.com/geocoding/v1')
    end

    def parse_it(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
