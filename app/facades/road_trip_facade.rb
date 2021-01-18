class RoadTripFacade
  class << self
    def road_trip(from, to)
      response = MapquestService.road_trip(from, to)
      RoadTrip.new(response)
    end
  end
end
