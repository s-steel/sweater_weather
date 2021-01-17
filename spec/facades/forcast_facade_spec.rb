require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'returns weather data for a city', :vcr do
    latitude = 45.456
    longitude = -123.8382
    result = ForecastFacade.city_search(latitude, longitude)
    expect(result).to be_a(Hash)
    expect(result[:current_weather]).to be_a(WeatherCurrent)
    expect(result[:daily_weather].length).to eq(5)
    expect(result[:hourly_weather].length).to eq(8)
  end

  it 'returns nil if invalid params entered', :vcr do
    latitude = 45.456
    longitude = nil
    result = ForecastFacade.city_search(latitude, longitude)
    expect(result).to be_a(Hash)
    expect(result[:error]).to eq('Invalid params')
  end
end
