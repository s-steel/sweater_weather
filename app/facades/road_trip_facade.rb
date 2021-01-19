class RoadTripFacade
  class << self
    def road_trip(from, to)
      response = MapquestService.road_trip(from, to)
      @road_trip = road_trip_data(response, from, to)
      time = hours_to_arrival(@road_trip.travel_time)
      weather = weather_at_arrival(time)
      {
        start_city: @road_trip.start_city,
        end_city: @road_trip.end_city,
        travel_time: @road_trip.travel_time,
        weather_at_eta: weather_info(weather)
      }
    end

    private

    def hourly_weather(data)
      data[:hourly].map do |hour|
        WeatherHourly.new(hour)
      end
    end

    def hours_to_arrival(data)
      data.split(',')[0].delete(' hours').to_i
    rescue StandardError
      nil
    end

    def weather_at_arrival(data)
      forecast = OpenweatherService.city_search(@road_trip.end_latitude, @road_trip.end_longitude)
      weather = hourly_weather(forecast)
      weather[data - 1]
    rescue StandardError
      nil
      # Rescue this for longer time frames
    end

    def weather_info(data)
      if data.nil?
        {}
      else
        {
          temperature: data.temperature,
          conditions: data.conditions
        }
      end
    end

    def road_trip_data(data, from, to)
      road_trip_object = RoadTrip.new(data)
      if road_trip_object.end_city.nil?
        road_trip_object.end_city = to
        road_trip_object.start_city = from
        road_trip_object.travel_time = 'impossible'
      end
      road_trip_object
    end
  end
end
