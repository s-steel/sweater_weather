require 'rails_helper'

RSpec.describe LocationFacade do

  it 'returns lat and lng for a city' do
    city = 'tillamook, or'
    result = LocationFacade.city_search(city)

    expect(result).to be_a(Location)
    expect(result.latitude).to eq(45.456045)
    expect(result.longitude).to eq(-123.838253)
  end

  it 'returns nil if invalid params entered' do
    city = ''
    result = LocationFacade.city_search(city)

    expect(result).to be_a(Location)
    expect(result.latitude).to be nil
    expect(result.longitude).to be nil
  end
end
