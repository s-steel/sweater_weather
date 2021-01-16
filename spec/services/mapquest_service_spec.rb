require 'rails_helper'

describe 'Mapquest Service' do
  describe 'Mapquest loction search' do
    it 'query with valid params all undercase' do
      results = MapquestService.city_search('tillamook,or')
      require 'pry', binding.pry
      # expect(results.first).to have_key(:id)
      # expect(results.first).to have_key(:title)
      # expect(results.first).to have_key(:vote_average)
    end

    it 'query with valid params with capitalization' do
      # results = MapquestService.city_search('Tillamook,OR')
    end
  end
end
