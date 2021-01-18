require 'rails_helper'

RSpec.describe 'Road Trip', type: :request do
  describe 'POST /api/v1/road_trip' do
    before :each do
      @user = User.create!(email: 'test@example.com',
                           password: 'password',
                           password_confirmation: 'password')
    end

    it 'can login the user and return their api key' do
      post '/api/v1/road_trip', params: {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }.to_json, headers: { 'Content-Type' => 'application/json',
                            'Accept' => 'application/json' }

      expect(response).to be_successful
      # expect(response).to have_http_status(200)
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
    end
  end
end