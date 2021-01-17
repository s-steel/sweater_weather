require 'rails_helper'

RSpec.describe 'Weather API', type: :request do
  describe 'GET /weather' do
    it 'can return weather data', :vcr do
      get '/api/v1/forecast?location=denver,co', headers: { 'Content-Type' => 'application/json',
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
      expect(forecast_data).to_not have_key(:lat)
      expect(forecast_data).to_not have_key(:lon)
      expect(forecast_data).to_not have_key(:timezone)
      expect(daily.length).to eq(5)
      expect(hourly.length).to eq(8)

      expect(current[:datetime]).to be_a(String)
      expect(current[:sunrise]).to be_a(String)
      expect(current[:sunset]).to be_a(String)
      expect(current[:temperature]).to be_a(Float)
      expect(current[:feels_like]).to be_a(Float)
      expect(current[:humidity]).to be_a(Integer)
      expect(current[:uvi]).to be_a(Float)
      expect(current[:visibility]).to be_a(Integer)
      expect(current[:conditions]).to be_a(String)
      expect(current[:icon]).to be_a(String)
      expect(current).to_not have_key(:pressure)
      expect(current).to_not have_key(:dew_point)
      expect(current).to_not have_key(:wind_speed)
      expect(current).to_not have_key(:weather)
      expect(current).to_not have_key(:wind_deg)

      expect(daily[0][:date]).to be_a(String)
      expect(daily[0][:sunrise]).to be_a(String)
      expect(daily[0][:sunset]).to be_a(String)
      expect(daily[0][:max_temp]).to be_a(Float)
      expect(daily[0][:min_temp]).to be_a(Float)
      expect(daily[0][:conditions]).to be_a(String)
      expect(daily[0][:icon]).to be_a(String)
      expect(daily[0]).to_not have_key(:temp)
      expect(daily[0]).to_not have_key(:humidity)
      expect(daily[0]).to_not have_key(:dew_point)
      expect(daily[0]).to_not have_key(:clouds)
      expect(daily[0]).to_not have_key(:pop)
      expect(daily[0]).to_not have_key(:wind_speed)

      expect(hourly[0][:time]).to be_a(String)
      expect(hourly[0][:temperature]).to be_a(Float)
      expect(hourly[0][:wind_speed]).to be_a(String)
      expect(hourly[0][:wind_direction]).to be_a(String)
      expect(hourly[0][:conditions]).to be_a(String)
      expect(hourly[0][:icon]).to be_a(String)
      expect(hourly[0]).to_not have_key(:temp)
      expect(hourly[0]).to_not have_key(:humidity)
      expect(hourly[0]).to_not have_key(:dew_point)
      expect(hourly[0]).to_not have_key(:clouds)
      expect(hourly[0]).to_not have_key(:pop)
      expect(hourly[0]).to_not have_key(:feels_like)
    end

    it 'returns error with invalid params', :vcr do
      get '/api/v1/forcast?location=', headers: { 'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      expect(response).to have_http_status(404)
      forecast = JSON.parse(response.body, symbolize_names: true)
      expect(forecast[:error]).to eq('City not found, try again with proper params => ex. denver,co')
    end
  end
end
