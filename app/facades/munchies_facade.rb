class MunchiesFacade
  class << self
    def restaurant_search(from, to, categories)
      trip_info = travel_info(from, to)
      weather = forecast(trip_info.end_latitude, trip_info.end_longitude)
      open_at = arrival_time(from, to)
      restaurant_info = find_restaurants(trip_info.end_city, open_at, categories).first
      {
        destination_city: trip_info.end_city,
        travel_time: trip_info.travel_time,
        forecast: {
          summary: weather.conditions,
          temperature: weather.temperature.round(2).to_s
        },
        restaurant: {
          name: restaurant_info.name,
          address: restaurant_info.address.join
        }
      }
    end

    private

    def travel_info(from, to)
      route_response = MapquestService.road_trip(from, to)
      RoadTrip.new(route_response)
    end

    def forecast(end_latitude, end_longitude)
      forecast = OpenweatherService.city_search(end_latitude, end_longitude)
      current_weather = WeatherCurrent.new(forecast)
    end

    def arrival_time(from, to)
      travel_time = MapquestService.road_trip(from, to)[:route][:time]
      Time.now.to_i + travel_time
    end

    def find_restaurants(location, open_at, categories)
      restaurant_response = YelpService.restaurant_search(location, open_at, categories)
      restaurant_response.map do |rest|
        Restaurant.new(rest)
      end
    end
  end
end
