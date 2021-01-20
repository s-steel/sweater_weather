require 'rails_helper'

describe 'Forecast poro' do
  before :each do
    @service_response = { lat: 45.456,
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
    @response_data = { current_weather: WeatherCurrent.new(@service_response),
                       daily_weather: [WeatherDaily.new(@service_response)],
                       hourly_weather: [WeatherHourly.new(@service_response)] }
  end

  it 'creates Forecast objects' do
    forecast_poro = Forecast.new(@response_data)
    expect(forecast_poro.current_weather).to be_a(WeatherCurrent)
    expect(forecast_poro.daily_weather).to be_an(Array)
    expect(forecast_poro.daily_weather[0]).to be_a(WeatherDaily)
    expect(forecast_poro.hourly_weather).to be_an(Array)
    expect(forecast_poro.hourly_weather[0]).to be_a(WeatherHourly)
  end

  it 'with invalid city query' do
    response = nil
    forecast_poro = Forecast.new(response)
    expect(forecast_poro.current_weather).to be nil
    expect(forecast_poro.daily_weather).to be nil
    expect(forecast_poro.hourly_weather).to be nil
  end
end
