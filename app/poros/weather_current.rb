class WeatherCurrent
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime = DateTime.strptime(data[:current][:dt].to_s, '%s')
    @sunrise = DateTime.strptime(data[:current][:sunrise].to_s, '%s')
    @sunset = DateTime.strptime(data[:current][:sunset].to_s, '%s')
    @temperature = fahrenheit(data[:current][:temp])
    @feels_like = fahrenheit(data[:current][:feels_like])
    @humidity = data[:current][:humidity]
    @uvi = data[:current][:uvi]
    @visibility = data[:current][:visibility]
    @conditions = data[:current][:weather][0][:description]
    @icon = data[:current][:weather][0][:icon]
  rescue StandardError
    @datetime = nil
    @sunrise = nil
    @sunset = nil
    @temperature = nil
    @feels_like = nil
    @humidity = nil
    @uvi = nil
    @visibility = nil
    @conditions = nil
    @icon = nil
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
