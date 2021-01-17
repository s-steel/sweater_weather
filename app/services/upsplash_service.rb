require 'faraday'
require 'json'

class UpsplashService
  class << self
    def image_search(location)
      response = conn.get('search/photos') do |r|
        r.params[:query] = location
      end
      parse_it(response)
    end

    private

    def conn
      Faraday.new('https://api.unsplash.com') do |req|
        req.params[:client_id] = ENV['UPSPLASH_ACCESS_KEY']
        req.adapter Faraday.default_adapter
      end
    end

    def parse_it(data)
      JSON.parse(data.body, symbolize_names: true)
    end
  end
end
