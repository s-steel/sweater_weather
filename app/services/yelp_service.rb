require 'faraday'
require 'json'

class YelpService
  class << self
    def restaurant_search(location, open_at, categories)
      response = conn.get('v3/businesses/search') do |req|
        req.params['location'] = location
        req.params['open_at'] = open_at
        req.params['categories'] = categories
      end
      parse_it(response)['businesses']
    end

private

    def parse_it(data)
      JSON.parse(data.body, symboloze_names: true)
    end

    def conn
      Faraday.new('https://api.yelp.com') do |req|
        req.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
        req.adapter Faraday.default_adapter
      end
    end
  end
end
