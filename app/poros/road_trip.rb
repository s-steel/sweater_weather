class RoadTrip
  attr_accessor :start_city,
                :end_city,
                :travel_time
  attr_reader :end_latitude,
              :end_longitude

  def initialize(data)
    @start_city = location_start_city(data[:route][:locations])
    @end_city = location_end_city(data[:route][:locations])
    @travel_time = time_in_hours(data[:route][:time])
    @end_latitude = data[:route][:locations][1][:latLng][:lat]
    @end_longitude = data[:route][:locations][1][:latLng][:lng]
  rescue StandardError
    @start_city = nil
    @end_city = nil
    @travel_time = nil
    @end_latitude = nil
    @end_longitude = nil
  end

  def time_in_hours(seconds)
    hours = Time.at(seconds).utc.strftime("%H")
    minutes = Time.at(seconds).utc.strftime("%M")
    "#{hours} hours, #{minutes} minutes"
  end

  def location_start_city(location)
    city = location[0][:adminArea5]
    state = location[0][:adminArea3]
    "#{city}, #{state}"
  end

  def location_end_city(location)
    city = location[1][:adminArea5]
    state = location[1][:adminArea3]
    "#{city}, #{state}"
  end
end
