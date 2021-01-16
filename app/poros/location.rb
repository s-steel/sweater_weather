class Location
  attr_reader :latitude,
              :longitude

  def initialize(data)
    @latitude = data[:results][0][:locations][0][:latLng][:lat]
    @longitude = data[:results][0][:locations][0][:latLng][:lng]
  rescue StandardError
    @latitude = nil
    @longitude = nil
  end
end
