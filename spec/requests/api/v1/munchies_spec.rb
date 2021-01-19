require 'rails_helper'

RSpec.describe 'Yelp API', type: :request do
  describe 'GET /munchies' do
    it 'can return munchie data', :vcr do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese', headers: { 'Content-Type' => 'application/json',
                                                               'Accept' => 'application/json' }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      json_data = JSON.parse(response.body, symbolize_names: true)
      attributes = json_data[:data][:attributes]
      expect(json_data[:data][:id]).to be nil
      expect(json_data[:data][:type]).to eq('munchie')
      expect(attributes).to have_key(:destination_city)
      expect(attributes[:destination_city]).to be_a(String)
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a(String)
      expect(attributes[:forecast]).to be_a(Hash)
      expect(attributes[:forecast][:summary]).to be_a(String)
      expect(attributes[:forecast][:temperature]).to be_a(String)
      expect(attributes[:restaurant][:name]).to be_a(String)
      expect(attributes[:restaurant][:address]).to be_a(String)
    end

    it 'returns error with invalid params', :vcr do
      get '/api/v1/munchies?start=denver,co&food=chinese', headers: { 'Content-Type' => 'application/json',
        'Accept' => 'application/json' }
      expect(response).to have_http_status(422)
      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:error]).to eq('Invalid params')
    end
  end
end
