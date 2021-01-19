require 'rails_helper'

RSpec.describe MunchiesFacade do
  it 'returns travel info, forecast, and restaurant info', :vcr do
    from = 'denver,co'
    to = 'pueblo,co'
    categories = 'chinese'
    result = MunchiesFacade.restaurant_search(from, to, categories)

    expect(result.end_city).to be_a(String)
    # expect(result.start_city).to be_a(String)
    # expect(result.travel_time).to be_a(String)
    # expect(result.end_longitude).to be_a(Float)
    # expect(result.end_latitude).to be_a(Float)
  end

  xit 'returns nil if invalid params entered', :vcr do
    from = 'tillamook,or'
    to = ''
    result = MunchiesFacade.restaurant_search(from, to)
    expect(result).to be_a(RoadTrip)
    expect(result.end_latitude).to be nil
    expect(result.end_longitude).to be nil
    expect(result.end_city).to be nil
    expect(result.start_city).to be nil
    expect(result.travel_time).to be nil
  end
end