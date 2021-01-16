require 'rails_helper'

describe 'OpenWeather Service' do
  describe 'OpenWeather loction search' do
    it 'query with valid params all undercase', :vcr do
      latitude = 45.456
      longitude = -123.8382
      results = OpenweatherService.city_search(latitude, longitude)

      expect(results[:lat]).to eq(latitude)
      expect(results[:lon]).to eq(longitude)
      expect(results).to have_key(:current)
      expect(results).to have_key(:hourly)
      expect(results).to have_key(:daily)
      expect(results).to_not have_key(:alerts)
      expect(results).to_not have_key(:minutely)
      expect(results[:hourly]).to be_an(Array)
      expect(results[:current]).to be_a(Hash)
      expect(results[:daily]).to be_an(Array)
    end

    it 'query with invalid params', :vcr do 
      latitude = 45.456
      longitude = nil
      results = OpenweatherService.city_search(latitude, longitude)
      expect(results).to be_a(Hash)
      expect(results[:message]).to eq('Nothing to geocode')
    end
  end
end
