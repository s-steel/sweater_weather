class ForecastSerializer
  # include FastJsonapi::ObjectSerializer
  # attributes :current_weather, :daily_weather, :hourly_weather
  def self.forecast(object)
    {
      "data": {
        "id": nil,
        "attributes": {
          "current_weather": object[:current_weather],
          "daily_weather": object[:daily_weather],
          "hourly_weather": object[:hourly_weather]
        }
      }
    }
  end
end
