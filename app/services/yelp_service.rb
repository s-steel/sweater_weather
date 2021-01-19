require 'faraday'
require 'json'

class YelpService
  class << self
    def restaurant_search(location, open_at, categories)
      
    end
  # def self.businesses(lat, lon)
  #   name_response = conn.get('v3/businesses/search') do |req|
  #     req.params['latitude'] = lat
  #     req.params['longitude'] = lon
  #   end
  #   parse_it(name_response)
  # end

  # def self.businesses_location(location)
  #   name_response = conn.get('v3/businesses/search') do |req|
  #     req.params['location'] = location
  #   end
  #   parse_it(name_response)
  # end

  # def self.rating_sort(location)
  #   name_response = conn.get('v3/businesses/search') do |req|
  #     req.params['location'] = location
  #     req.params['sort_by'] = 'rating'
  #   end
  #   parse_it(name_response)
  # end

    private
    
    def self.parse_it(data)
      JSON.parse(data.body, symboloze_names: true)
    end
    
    def self.conn
      yelp_key = 'Fv3iehwgkB9_XvWrJSKFFsVVy-kj3zdUeldW9lQ3JEt_9AZ-sTugSHrY5qZPORd5bL27VWpW4rsS1bv9ytUVMLX7Hv-eBn4oGXPVLgWgt6Cd3SIsDJ32sXvJU_4FYHYx'
      Faraday.new('https://api.yelp.com') do |req|
        req.headers['Authorization'] = "Bearer #{yelp_key}"
      end
    end
  end
end