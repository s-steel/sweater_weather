class Location
  attr_reader :latitude,
              :longitude

  def initialize(data)
    @latitude = find_coordinates(data, :lat)
    @longitude = find_coordinates(data, :lng)
  rescue StandardError
    @latitude = nil
    @longitude = nil
  end

  def find_coordinates(data, lat_lon)
    if data[:results][0][:locations][0][:adminArea5] == ''
      nil
    else
      data[:results][0][:locations][0][:latLng][lat_lon]
    end
  end
end



