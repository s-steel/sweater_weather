require 'rails_helper'

describe 'Weather poro' do
  before :each do
    @response_data = { dt: 1_610_827_200,
                       sunrise: 1_610_812_233,
                       sunset: 1_610_845_173,
                       temp: { day: 285.23, min: 279.53, max: 285.23, night: 283.18, eve: 282.38,
                               morn: 280.02 },
                       feels_like: { day: 283.49, night: 281.13, eve: 279.91, morn: 277.06 },
                       pressure: 1029,
                       humidity: 56,
                       dew_point: 276.9,
                       wind_speed: 0.48,
                       wind_deg: 303,
                       weather: [{ id: 804, main: 'Clouds', description: 'overcast clouds',
                                   icon: '04d' }],
                       clouds: 98,
                       pop: 0.07,
                       uvi: 0.96 }
  end

  it 'creates weather objects' do
    weather_poro = WeatherDaily.new(@response_data)
    expect(weather_poro.date).to eq(DateTime.strptime(@response_data[:dt].to_s, '%s'))
    expect(weather_poro.sunrise).to eq(DateTime.strptime(@response_data[:sunrise].to_s, '%s'))
    expect(weather_poro.sunset).to eq(DateTime.strptime(@response_data[:sunset].to_s, '%s'))
    expect(weather_poro.max_temp).to be_a(Float)
    expect(weather_poro.min_temp).to be_a(Float)
    expect(weather_poro.conditions).to eq(@response_data[:weather][0][:description])
    expect(weather_poro.icon).to eq(@response_data[:weather][0][:icon])
  end

  it 'with invalid city query' do
    response = {
      "cod": '400',
      "message": 'Nothing to geocode'
    }
    weather_poro = WeatherDaily.new(response)
    expect(weather_poro.conditions).to be nil
    expect(weather_poro.sunrise).to be nil
  end
end
