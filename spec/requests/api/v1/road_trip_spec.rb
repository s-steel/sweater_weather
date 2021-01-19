require 'rails_helper'

RSpec.describe 'Road Trip', type: :request do
  describe 'POST /api/v1/road_trip' do
    before :each do
      @user = User.create!(email: 'test@example.com',
                           password: 'password',
                           password_confirmation: 'password')
    end

    it 'can login the user and return their api key', :vcr do
      post '/api/v1/road_trip', params: {
        "origin": 'Denver,CO',
        "destination": 'Pueblo,CO',
        "api_key": @user.api_key.to_s
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      road_trip_response = JSON.parse(response.body, symbolize_names: true)
      road_trip_data = road_trip_response[:data][:attributes]

      expect(road_trip_response[:data][:type]).to eq('roadtrip')
      expect(road_trip_response[:data][:id]).to eq(nil)
      expect(road_trip_data[:start_city]).to be_a(String)
      expect(road_trip_data[:end_city]).to be_a(String)
      expect(road_trip_data[:travel_time]).to be_a(String)
      expect(road_trip_data[:weather_at_eta]).to be_a(Hash)
      expect(road_trip_data[:weather_at_eta][:temperature]).to be_a(Float)
      expect(road_trip_data[:weather_at_eta][:conditions]).to be_a(String)

      expect(road_trip_data[:start_city]).to eq('Denver, CO')
      expect(road_trip_data[:end_city]).to eq('Pueblo, CO')
      expect(road_trip_data[:travel_time]).to eq('01 hours, 44 minutes')
    end

    it 'if no api key is given return 401 status', :vcr do
      wrong_api_key = 'wrongkeyhere'
      post '/api/v1/road_trip', params: {
        "origin": 'Denver,CO',
        "destination": 'Pueblo,CO',
        "api_key": wrong_api_key
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }
      expect(response).to have_http_status(401)
    end
  end
end
