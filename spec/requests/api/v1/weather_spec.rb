require 'rails_helper'

RSpec.describe 'Weather API', type: :request do
  describe 'GET /weather' do
    it 'can return weather data', :vcr do
      get '/api/v1/forcast?location=denver,co', headers: { 'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      forecast = JSON.parse(response.body, symbolize_names: true)
      forecast_data = forecast[:data]
      current = forecast_data[:attributes][:current_weather]
      daily = forecast_data[:attributes][:daily_weather]
      hourly = forecast_data[:attributes][:hourly_weather]
      expect(forecast_data[:id]).to be nil
      expect(forecast_data[:type]).to eq('forecast')
      expect(daily.length).to eq(5)
      expect(hourly.length).to eq(8)

    end
  end
end
