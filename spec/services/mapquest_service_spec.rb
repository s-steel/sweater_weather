require 'rails_helper'

describe 'Mapquest Service' do
  describe 'Mapquest loction search' do
    it 'query with valid params all undercase', :vcr do
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

    it 'query with valid params with capitalization', :vcr do
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

    it 'query with invalid params', :vcr do 
      results = MapquestService.city_search('')
      expect(results[:info][:statuscode]).to eq(400)
      expect(results[:info][:messages][0]).to eq('Illegal argument from request: Insufficient info for location')
    end

    it 'query with invalid params', :vcr do 
      results = MapquestService.city_search('dasgasfgd')
      city = results[:results][0][:locations][0][:adminArea5]
      expect(city).to eq('')
    end
  end

  describe 'Mapquest road trip' do
    it 'query with valid params all undercase', :vcr do
      from = 'tillamook,or'
      to = 'denver,co'
      results = MapquestService.road_trip(from, to)
      route = results[:route]
      expect(route).to have_key(:distance)
      expect(route[:distance]).to be_a(Numeric)
      expect(route).to have_key(:time)
      expect(route[:time]).to be_a(Numeric)
      expect(route[:locations][1][:latLng]).to have_key(:lng)
      expect(route[:locations][1][:latLng]).to have_key(:lat)
      expect(route[:locations][1][:latLng][:lng]).to be_a(Float)
      expect(route[:locations][1][:latLng][:lng]).to eq(-104.984853)
      expect(route[:locations][1][:latLng][:lat]).to be_a(Float)
      expect(route[:locations][1][:latLng][:lat]).to eq(39.738453)
    end

    it 'query with valid params with capitalization', :vcr do
      from = 'Tillamook,OR'
      to = 'denver,CO'
      results = MapquestService.road_trip(from, to)
      route = results[:route]
      expect(route).to have_key(:distance)
      expect(route[:distance]).to be_a(Numeric)
      expect(route).to have_key(:time)
      expect(route[:time]).to be_a(Numeric)
      expect(route[:locations][1][:latLng]).to have_key(:lng)
      expect(route[:locations][1][:latLng]).to have_key(:lat)
      expect(route[:locations][1][:latLng][:lng]).to be_a(Float)
      expect(route[:locations][1][:latLng][:lng]).to eq(-104.984853)
      expect(route[:locations][1][:latLng][:lat]).to be_a(Float)
      expect(route[:locations][1][:latLng][:lat]).to eq(39.738453)
    end

    it 'query with invalid params', :vcr do 
      from = 'Tillamook,OR'
      to = ''
      results = MapquestService.road_trip(from, to)
      expect(results[:info][:statuscode]).to eq(611)
      expect(results[:info][:messages][0]).to eq('At least two locations must be provided.')
    end

    xit 'query with invalid params', :vcr do 
      from = 'Tillamook,OR'
      to = 'asfasrfgasdfg'
      results = MapquestService.road_trip(from, to)
      require 'pry', binding.pry
      expect(results[:info][:statuscode]).to eq(611)
      expect(results[:info][:messages][0]).to eq('At least two locations must be provided.')
    end
  end
end
