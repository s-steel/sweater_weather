require 'rails_helper'

describe 'Yelp Service' do
  describe 'Yelp loction search' do
    it 'query with valid params', :vcr do
      location = 'denver,co'
      results = YelpService.restaurant_search(location, open_at, categories)
      expect(results).to be_a(Hash)
      expect(results[0]).to have_key(:id)
      expect(results[0][:name]).to be_a(String)
      expect(results[0][:url]).to be_a(String)
      expect(results[0][:categories]).to be_an(Array)
      expect(results[0][:rating]).to be_a(Float)
      expect(results[0][:location]).to be_a(Hash)
      expect(results[0][:location][:address1]).to be_a(String)
      expect(results[0][:location][:address2]).to be_a(String)
      expect(results[0][:location][:address3]).to be_a(String)
      expect(results[0][:location][:city]).to be_a(String)
      expect(results[0][:location][:zipcode]).to be_a(String)
      expect(results[0][:location][:display_address]).to be_an(Array)
    end
  end
end
