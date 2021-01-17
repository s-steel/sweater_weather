require 'rails_helper'

RSpec.describe PhotoFacade do

  it 'returns a photo for a location', :vcr do
    city = 'denver,co'
    result = PhotoFacade.image_search(city)

    expect(result).to be_a(Photo)
    expect(result.location).to eq(city)
    expect(result.image_url).to eq('https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=srgb&fm=jpg&ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=85')
    expect(result.raw_image_url).to eq('https://images.unsplash.com/photo-1600041161228-519e6dd27bac?ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1')
    expect(result.source).to eq('https://unsplash.com')
    expect(result.author).to eq('Michael Kilcoyne')
    expect(result.author_profile).to eq('https://unsplash.com/@mikekilcoyne')
  end

  it 'returns nil if invalid params entered', :vcr do
    city = ''
    result = PhotoFacade.image_search(city)
    expect(result).to be_a(Photo)
    expect(result.location).to be nil
    expect(result.image_url).to be nil
    expect(result.raw_image_url).to be nil
    expect(result.source).to be nil
    expect(result.author).to be nil
    expect(result.author_profile).to be nil
  end
end
