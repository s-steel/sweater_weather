class RoadTripFacade
  class << self
    def road_trip(from, to)
      response = MapquestService.road_trip(from, to)
      road_trip = RoadTrip.new(response)
      # weather = ForecastFacade.road_trip_prediction(road_trip.end_latitude, road_trip.end_longitude)
    end
  end
end
