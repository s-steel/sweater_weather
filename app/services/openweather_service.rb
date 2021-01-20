require 'faraday'
require 'json'

class OpenweatherService
  class << self
    def city_search(latitude, longitude)
      weather_response = conn.get do |req|
        req.params['lat'] = latitude
        req.params['lon'] = longitude
        req.params['exclude'] = 'alerts,minutely'
      end
      parse_it(weather_response)
    end

    private

    def conn
      Faraday.new('https://api.openweathermap.org/data/2.5/onecall') do |req|
        req.params['appid'] = ENV['OPENWEATHER_KEY']
        req.adapter Faraday.default_adapter
      end
    end

    def parse_it(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
