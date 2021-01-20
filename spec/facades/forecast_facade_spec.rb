require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'returns weather data for a city', :vcr do
    latitude = 45.456
    longitude = -123.8382
    daily_limit = 5
    hourly_limit = 8
    result = ForecastFacade.city_search(latitude, longitude, daily_limit, hourly_limit)
    expect(result).to be_a(Forecast)
    expect(result.current_weather).to be_a(WeatherCurrent)
    expect(result.daily_weather[0]).to be_a(WeatherDaily)
    expect(result.hourly_weather[0]).to be_a(WeatherHourly)
    expect(result.daily_weather.length).to eq(5)
    expect(result.hourly_weather.length).to eq(8)
  end

  it 'returns nil if invalid params entered', :vcr do
    latitude = 45.456
    longitude = nil
    daily_limit = 5
    hourly_limit = 8
    result = ForecastFacade.city_search(latitude, longitude, daily_limit, hourly_limit)
    expect(result).to be_a(Hash)
    expect(result[:error]).to eq('Invalid params')
  end
end
