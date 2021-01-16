require 'rails_helper'

describe 'Mapquest Service' do
  describe 'Mapquest loction search' do
    it 'query with valid params all undercase' do
      results = MapquestService.city_search('tillamook,or')
      lat_lng = results[:results][0][:locations][0][:latLng]
      expect(results).to have_key(:results)
      expect(lat_lng).to have_key(:lat)
      expect(lat_lng).to have_key(:lng)
      expect(lat_lng[:lat]).to be_an(Float)
      expect(lat_lng[:lng]).to be_an(Float)
      expect(lat_lng[:lat]).to eq(45.456045)
      expect(lat_lng[:lng]).to eq(-123.838253)
    end

    it 'query with valid params with capitalization' do
      results = MapquestService.city_search('Tillamook,OR')
      lat_lng = results[:results][0][:locations][0][:latLng]
      expect(results).to have_key(:results)
      expect(lat_lng).to have_key(:lat)
      expect(lat_lng).to have_key(:lng)
      expect(lat_lng[:lat]).to be_an(Float)
      expect(lat_lng[:lng]).to be_an(Float)
      expect(lat_lng[:lat]).to eq(45.456045)
      expect(lat_lng[:lng]).to eq(-123.838253)
    end

    it 'query with invalid params' do 
      results = MapquestService.city_search('')
      expect(results[:info][:statuscode]).to eq(400)
      expect(results[:info][:messages][0]).to eq('Illegal argument from request: Insufficient info for location')
    end
  end
end
