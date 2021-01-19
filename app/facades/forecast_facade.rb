class ForecastFacade
  class << self
    def city_search(latitude, longitude, daily_limit = 7, hourly_limit = 48)
      response = OpenweatherService.city_search(latitude, longitude)
      {
        current_weather: WeatherCurrent.new(response),
        daily_weather: daily_weather(response, daily_limit),
        hourly_weather: hourly_weather(response, hourly_limit)
      }
    rescue StandardError
      {
        error: 'Invalid params'
      }
    end

    private

    def daily_weather(data, limit)
      data[:daily].map do |day|
        WeatherDaily.new(day)
      end.take(limit)
    end

    def hourly_weather(data, limit)
      data[:hourly].map do |hour|
        WeatherHourly.new(hour)
      end.take(limit)
    end
  end
end
