class Photo
  attr_reader :location,
              :image_url,
              :raw_image_url,
              :source,
              :author,
              :author_profile

  def initialize(data)
    @location = nil
    @image_url = data[:urls][:full]
    @raw_image_url = data[:urls][:raw]
    @source = 'https://unsplash.com'
    @author = data[:user][:name]
    @author_profile = data[:user][:links][:html]
  rescue StandardError
    @location = nil
    @image_url = nil
    @raw_image_url = nil
    @source = nil
    @author = nil
    @author_profile = nil
  end
end
