class WeatherHourly
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(data)
    @time = get_time(data[:dt])
    @temperature = fahrenheit(data[:temp])
    @wind_speed = get_wind_speed(data[:wind_speed])
    @wind_direction = get_wind_direction(data[:wind_deg])
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  rescue StandardError
    @time = nil
    @temperature = nil
    @wind_speed = nil
    @wind_direction = nil
    @conditions = nil
    @icon = nil
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end

  def get_time(datetime)
    date_time = DateTime.strptime(datetime.to_s, '%s')
    date_time.strftime('%H:%m')
  end

  def get_wind_speed(wind_data)
    wind_data * 2.2369
  end

  def get_wind_direction(wind_data)
    wind_data
  end
end
