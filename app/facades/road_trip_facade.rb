class RoadTripFacade
  class << self
    def road_trip(from, to)
      response = MapquestService.road_trip(from, to)
      @road_trip = RoadTrip.new(response)
      time = hours_to_arrival(@road_trip.travel_time)
      weather = weather_at_arrival(time)
      {
        start_city: @road_trip.start_city,
        end_city: @road_trip.end_city,
        travel_time: @road_trip.travel_time,
        weather_at_eta: {
          temperature: weather.temperature,
          conditions: weather.conditions
        }}
    end

    def hourly_weather(data)
      data[:hourly].map do |hour|
        WeatherHourly.new(hour)
      end
    end

    def hours_to_arrival(data)
      data.split(',')[0].delete(' hours').to_i
    end

    def weather_at_arrival(data)
      forecast = OpenweatherService.city_search(@road_trip.end_latitude, @road_trip.end_longitude)
      weather = hourly_weather(forecast)
      weather[data - 1]
      # Rescue this for longer time frames
    end
  end
end
