require 'rails_helper'

describe 'Weather poro' do
  before :each do
    @response_data = { dt: 1_610_830_800,
                       temp: 283.51,
                       feels_like: 281.98,
                       pressure: 1029,
                       humidity: 66,
                       dew_point: 277.44,
                       uvi: 0.91,
                       clouds: 1,
                       visibility: 10_000,
                       wind_speed: 0.38,
                       wind_deg: 282,
                       weather: [{ id: 800, main: 'Clear', description: 'clear sky', icon: '01d' }],
                       pop: 0 }
  end

  it 'creates weather objects' do
    weather_poro = WeatherHourly.new(@response_data)
    expect(weather_poro.conditions).to eq(@response_data[:weather][0][:description])
    expect(weather_poro.temperature).to be_a(Float)
    expect(weather_poro.icon).to eq(@response_data[:current][:weather][0][:icon])
    expect(weather_poro.wind_speed).to eq(@response_data[:wind_speed] * 2.2369)
    expect(weather_poro.time).to eq(Time.at(@response_data[:dt]).strftime('%H:%m'))
    expect(weather_poro.wind_direction).to eq('WNW')
  end

  xit 'with invalid city query' do
    response = {
      "cod": '400',
      "message": 'Nothing to geocode'
    }
    weather_poro = WeatherCurrent.new(response)
    expect(weather_poro.conditions).to be nil
    expect(weather_poro.sunrise).to be nil
  end
end
