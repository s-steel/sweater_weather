require 'rails_helper'

describe 'Photo poro' do
  before :each do
    @response_data = { id: 'hdzGZRCYMSU',
                       created_at: '2020-09-13T19:54:14-04:00',
                       updated_at: '2021-01-17T01:19:07-05:00',
                       promoted_at: nil,
                       width: 3888,
                       height: 5184,
                       color: '#d9f3f3',
                       blur_hash: 'LsG,S1WCtRkC02axWBays:adV@js',
                       description: nil,
                       alt_description: 'man in blue jacket and black pants riding on snowboard during daytime',
                       urls: { raw: "https://images.unsplash.com/photo-1600041161228-519e6dd27bac?ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixli
     b=rb-1.2.1",
                               full: 'https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=srgb&fm=jpg&ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=85',
                               regular: 'https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080',
                               small: 'https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=400',
                               thumb: 'https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=200' },
                       links: { self: 'https://api.unsplash.com/photos/hdzGZRCYMSU',
                                html: 'https://unsplash.com/photos/hdzGZRCYMSU',
                                download: 'https://unsplash.com/photos/hdzGZRCYMSU/download',
                                download_location: 'https://api.unsplash.com/photos/hdzGZRCYMSU/download' },
                       user: { id: 'uMT_KSln-6U',
                               username: 'mikekilcoyne',
                               name: 'Michael Kilcoyne',
                               portfolio_url: 'http://mikekilcoyne.com',
                               bio: 'I love capturing people, animal, places, and things in their element. ',
                               location: 'Istanbul, Turkey',
                               links: { self: 'https://api.unsplash.com/users/mikekilcoyne',
                                        html: 'https://unsplash.com/@mikekilcoyne',
                                        photos: 'https://api.unsplash.com/users/mikekilcoyne/photos',
                                        likes: 'https://api.unsplash.com/users/mikekilcoyne/likes',
                                        portfolio: 'https://api.unsplash.com/users/mikekilcoyne/portfolio',
                                        following: 'https://api.unsplash.com/users/mikekilcoyne/following',
                                        followers: 'https://api.unsplash.com/users/mikekilcoyne/followers' } } }
  end

  it 'creates photo objects' do
    photo_poro = Photo.new(@response_data)
    expect(photo_poro.location).to be nil
    expect(photo_poro.image_url).to eq(@response_data[:urls][:full])
    expect(photo_poro.raw_image_url).to eq(@response_data[:urls][:raw])
    expect(photo_poro.source).to eq('https://unsplash.com')
    expect(photo_poro.author).to eq(@response_data[:user][:name])
    expect(photo_poro.author_profile).to eq(@response_data[:user][:links][:html])
  end

  it 'with invalid params' do
    response = { total: 0, total_pages: 0, results: [] }
    photo_poro = Photo.new(response)
    expect(photo_poro.location).to be nil
    expect(photo_poro.image_url).to be nil
    expect(photo_poro.source).to be nil
    expect(photo_poro.author).to be nil
  end
end
