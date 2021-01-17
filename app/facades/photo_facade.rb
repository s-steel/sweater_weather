class PhotoFacade
  class << self
    def image_search(city)
      response = UpsplashService.image_search(city)[:results][0]
      Photo.new(response, city)
    rescue StandardError
      {
        error: 'No photos for this location'
      }
    end
  end
end
