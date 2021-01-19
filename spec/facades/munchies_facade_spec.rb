require 'rails_helper'

RSpec.describe MunchiesFacade do
  it 'returns travel info, forecast, and restaurant info', :vcr do
    from = 'denver,co'
    to = 'pueblo,co'
    categories = 'chinese'
    result = MunchiesFacade.restaurant_search(from, to, categories)
    expect(result).to be_a(Hash)
    expect(result[:destination_city]).to be_a(String)
    expect(result[:travel_time]).to be_a(String)
    expect(result[:forecast]).to be_a(Hash)
    expect(result[:forecast][:summary]).to be_a(String)
    expect(result[:forecast][:temperature]).to be_a(String)
    expect(result[:restaurant][:name]).to be_a(String)
    expect(result[:restaurant][:address]).to be_a(String)
  end
end
