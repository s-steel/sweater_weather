class RoadTripFacade
  class << self
    def road_trip(from, to)
      response = MapquestService.road_trip(from, to)
      @road_trip = RoadTrip.new(response)
      time = hours_to_arrival(@road_trip.travel_time)
      weather = weather_at_arrival(time)
      
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
      weather[data + 1]
    end
  end
end


# road_trip.travel_time.delete('hoursminutes').split(',')[0].delete(' ').to_i
# weather[x + 1]
