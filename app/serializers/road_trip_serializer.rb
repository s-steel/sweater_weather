class RoadTripSerializer
  # include FastJsonapi::ObjectSerializer
  # attributes :current_weather, :daily_weather, :hourly_weather
  def self.road_trip(object)
    {
      "data": {
        "id": nil,
        "type": "roadtrip",
        "attributes": {
          "start_city": object[:start_city],
          "end_city": object[:end_city],
          "travel_time": object[:travel_time],
          "weather_at_eta": object[:weather_at_eta]
        }
      }
    }
  end
end
