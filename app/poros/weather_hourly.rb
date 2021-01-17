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
    date_time = Time.at(datetime)
    date_time.strftime('%H:%m')
  end

  def get_wind_speed(wind_data)
    wind_data * 2.2369
  end

  def get_wind_direction(wind_data)
    if wind_data >= 11.25 && wind_data < 33.75
      'NNE'
    elsif wind_data >=  33.75 && wind_data <  56.25
      'NE'
    elsif wind_data >=  56.25 && wind_data <  78.75
      'ENE'
    elsif wind_data >=  78.75 && wind_data < 101.25
      'E'
    elsif wind_data >= 101.25 && wind_data < 123.75
      'ESE'
    elsif wind_data >= 123.75 && wind_data < 146.25
      'SE'
    elsif wind_data >= 146.25 && wind_data < 168.75
      'SSE'
    elsif wind_data >= 168.75 && wind_data < 191.25
      'S'
    elsif wind_data >= 191.25 && wind_data < 213.75
      'SSW'
    elsif wind_data >= 213.75 && wind_data < 236.25
      'SW'
    elsif wind_data >= 236.25 && wind_data < 258.75
      'WSW'
    elsif wind_data >= 258.75 && wind_data < 281.25
      'W'
    elsif wind_data >= 281.25 && wind_data < 303.75
      'WNW'
    elsif wind_data >= 303.75 && wind_data < 326.25
      'NW'
    elsif wind_data >= 326.25 && wind_data < 348.75
      'NNW'
    else
      'N'
    end
  end
end
