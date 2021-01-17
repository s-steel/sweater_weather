require 'rails_helper'

RSpec.describe 'Weather API', type: :request do
  describe 'GET /weather' do
    it 'can return weather data' do
      get 'api/v1/forcast?location=denver,co', headers: { 'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
require 'pry', binding.pry
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      forcast = JSON.parse(response.body, symbolize_names: true)
      merchant_data = forcast[:data]
      expect(forcast).to_not be_empty
    end
  end
end
