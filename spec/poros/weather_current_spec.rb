require 'rails_helper'

describe 'Weather poro' do
  before :each do
    @response_data = { lat: 45.456,
                       lon: -123.8382,
                       timezone: 'America/Los_Angeles',
                       timezone_offset: -28_800,
                       current: { dt: 1_610_830_879,
                                  sunrise: 1_610_812_233,
                                  sunset: 1_610_845_173,
                                  temp: 283.51,
                                  feels_like: 281.17,
                                  pressure: 1029,
                                  humidity: 66,
                                  dew_point: 277.44,
                                  uvi: 0.91,
                                  clouds: 1,
                                  visibility: 10_000,
                                  wind_speed: 1.54,
                                  wind_deg: 310,
                                  weather: [{ id: 800, main: 'Clear', description: 'clear sky', icon: '01d' }] },
                       hourly: [{ dt: 1_610_830_800,
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
                                  pop: 0 }],
                       daily: [{ dt: 1_610_827_200,
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
                                 uvi: 0.96 }] }
  end

  it 'creates weather objects' do
    weather_poro = WeatherCurrent.new(@response_data)
    expect(weather_poro.conditions).to eq(@response_data[:current][:weather][0][:description])
    expect(weather_poro.datetime).to eq(Time.at(@response_data[:current][:dt]))
    expect(weather_poro.feels_like).to be_a(Float)
    expect(weather_poro.humidity).to eq(@response_data[:current][:humidity])
    expect(weather_poro.icon).to eq(@response_data[:current][:weather][0][:icon])
    expect(weather_poro.sunrise).to eq(Time.at(@response_data[:current][:sunrise]))
    expect(weather_poro.sunset).to eq(Time.at(@response_data[:current][:sunset]))
    expect(weather_poro.temperature).to be_a(Float)
    expect(weather_poro.uvi).to eq(@response_data[:current][:uvi])
    expect(weather_poro.visibility).to eq(@response_data[:current][:visibility])
  end

  it 'with invalid city query' do
    response = {
      "cod": '400',
      "message": 'Nothing to geocode'
    }
    weather_poro = WeatherCurrent.new(response)
    expect(weather_poro.conditions).to be nil
    expect(weather_poro.sunrise).to be nil
  end
end
