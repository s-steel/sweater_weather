require 'rails_helper'

RSpec.describe RoadTripFacade do
  it 'returns road trip info and weather info', :vcr do
    from = 'tillamook,or'
    to = 'denver,co'
    result = RoadTripFacade.road_trip(from, to)

    expect(result[:start_city]).to be_a(String)
    expect(result[:end_city]).to be_a(String)
    expect(result[:travel_time]).to be_a(String)
    expect(result[:weather_at_eta]).to be_a(Hash)
    expect(result[:weather_at_eta][:temperature]).to be_a(Float)
    expect(result[:weather_at_eta][:conditions]).to be_a(String)

    expect(result[:start_city]).to eq('Tillamook, OR')
    expect(result[:end_city]).to eq('Denver, CO')
  end

  it 'returns nil if invalid params entered', :vcr do
    from = 'tillamook,or'
    to = ''
    result = RoadTripFacade.road_trip(from, to)
    expect(result[:error]).to eq('Invalid params')
  end
end
