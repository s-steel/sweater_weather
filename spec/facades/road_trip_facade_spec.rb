require 'rails_helper'

RSpec.describe RoadTripFacade do
  it 'returns road trip info and weather info', :vcr do
    from = 'tillamook,or'
    to = 'denver,co'
    result = RoadTripFacade.road_trip(from, to)

    expect(result).to be_a(RoadTrip)
    expect(result.end_city).to be_a(String)
    expect(result.start_city).to be_a(String)
    expect(result.travel_time).to be_a(String)
    expect(result.end_longitude).to be_a(Float)
    expect(result.end_latitude).to be_a(Float)
  end

  it 'returns nil if invalid params entered', :vcr do
    from = 'tillamook,or'
    to = ''
    result = RoadTripFacade.road_trip(from, to)
    expect(result).to be_a(RoadTrip)
    expect(result.end_latitude).to be nil
    expect(result.end_longitude).to be nil
    expect(result.end_city).to be nil
    expect(result.start_city).to be nil
    expect(result.travel_time).to be nil
  end
end
