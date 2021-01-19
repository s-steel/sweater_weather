class MunchiesFacade
  class << self
    def restaurant_search(from, to, categories)
      # route_response = MapquestService.road_trip(from, to)
      # @travel_info = RoadTrip.new(route_response)
      # forecast = OpenweatherService.city_search(@road_trip.end_latitude, @road_trip.end_longitude)
      # current_weather = WeatherCurrent.new(forecast)
      trip_info = travel_info(from, to)
      weather = forecast(trip_info.end_latitude, trip_info.end_longitude)
      open_at = arrival_time(from, to)
      require 'pry', binding.pry
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
  #   def hourly_weather(data)
  #     data[:hourly].map do |hour|
  #       WeatherHourly.new(hour)
  #     end
  #   end

  #   def hours_to_arrival(data)
  #     data.split(',')[0].delete(' hours').to_i
  #   end

  #   def weather_at_arrival(data)
  #     forecast = OpenweatherService.city_search(@road_trip.end_latitude, @road_trip.end_longitude)
  #     weather = hourly_weather(forecast)
  #     weather[data - 1]
  #     # Rescue this for longer time frames
  #   end
  end
end
