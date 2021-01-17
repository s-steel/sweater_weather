require 'rails_helper'

describe 'Upsplash Service' do
  describe 'Upsplash loction search' do
    it 'query with valid params', :vcr do
      location = 'denver,co'
      results = UpsplashService.image_search(location)

      expect(results).to have_key(:results)
      expect(results[:results]).to be_an(Array)
      expect(results[:results][0]).to have_key(:id)
      expect(results[:results][0][:urls]).to be_a(Hash)
      expect(results[:results][0][:urls]).to be_a(Hash)
      expect(results[:results][0][:urls]).to have_key(:raw)
      expect(results[:results][0][:urls][:raw]).to be_a(String)
      expect(results[:results][0][:urls]).to have_key(:full)
      expect(results[:results][0][:urls][:full]).to be_a(String)
    end

    it 'query with invalid params', :vcr do
      location = nil
      results = UpsplashService.image_search(location)
      expect(results).to be_a(Hash)
      expect(results[:total]).to eq(0)
      expect(results[:total_pages]).to eq(0)
      expect(results[:results]).to eq([])
    end
  end
end
