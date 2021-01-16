class WeatherDaily
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = DateTime.strptime(data[:dt].to_s, '%s')
    @sunrise = DateTime.strptime(data[:sunrise].to_s, '%s')
    @sunset = DateTime.strptime(data[:sunset].to_s, '%s')
    @max_temp = fahrenheit(data[:temp][:max])
    @min_temp = fahrenheit(data[:temp][:min])
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  rescue StandardError
    @date = nil
    @sunrise = nil
    @sunset = nil
    @max_temp = nil
    @min_temp = nil
    @conditions = nil
    @icon = nil
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
