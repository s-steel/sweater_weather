class PhotoSerializer
  # include FastJsonapi::ObjectSerializer
  # attributes :current_weather, :daily_weather, :hourly_weather
  def self.background_image(object)
    {
      "data": {
        "id": nil,
        "type": "image",
        "attributes": {
          "image": {
            "location": object.location,
            "image_url": object.image_url,
            "raw_image_url": object.raw_image_url,
            "credit": {
              "source": object.source,
              "author": object.author,
              "author_profile": object.author_profile
            }
          }
        }
      }
    }
  end
end
