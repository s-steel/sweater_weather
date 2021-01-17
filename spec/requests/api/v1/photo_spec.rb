require 'rails_helper'

RSpec.describe 'Weather API', type: :request do
  describe 'GET /weather' do
    it 'can return weather data', :vcr do
      get '/api/v1/backgrounds?location=denver,co', headers: { 'Content-Type' => 'application/json',
                                                               'Accept' => 'application/json' }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
      photo = JSON.parse(response.body, symbolize_names: true)
      photo_data = photo[:data]
      image = photo_data[:attributes][:image]
      expect(photo_data[:id]).to be nil
      expect(photo_data[:type]).to eq('image')
      expect(image).to have_key(:location)
      expect(image[:location]).to be_a(String)
      expect(image).to have_key(:image_url)
      expect(image[:image_url]).to be_a(String)
      expect(image).to have_key(:raw_image_url)
      expect(image[:raw_image_url]).to be_a(String)
      expect(image[:credit]).to have_key(:source)
      expect(image[:credit][:source]).to be_a(String)
      expect(image[:credit]).to have_key(:author)
      expect(image[:credit][:author]).to be_a(String)
      expect(image[:credit]).to have_key(:author_profile)
      expect(image[:credit][:author_profile]).to be_a(String)
    end

    it 'returns error with invalid params', :vcr do
      get '/api/v1/backgrounds?location=', headers: { 'Content-Type' => 'application/json',
                                                      'Accept' => 'application/json' }
      expect(response).to have_http_status(404)
      forecast = JSON.parse(response.body, symbolize_names: true)
      expect(forecast[:error]).to eq('City not found, try again with proper params => ex. denver,co')
    end
  end
end
