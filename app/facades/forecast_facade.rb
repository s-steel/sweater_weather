class ForecastFacade
  class << self
    def city_search(latitude, longitude)
      response = OpenweatherService.city_search(latitude, longitude)
      {
        current_weather: WeatherCurrent.new(response),
        daily_weather: daily_weather(response),
        hourly_weather: hourly_weather(response)
      }
    rescue StandardError
      {
        error: 'Invalid params'
      }
    end

    private

    def daily_weather(data)
      data[:daily].map do |day|
        WeatherDaily.new(day)
      end.take(5)
    end

    def hourly_weather(data)
      data[:hourly].map do |hour|
        WeatherHourly.new(hour)
      end.take(8)
    end
  end
end
