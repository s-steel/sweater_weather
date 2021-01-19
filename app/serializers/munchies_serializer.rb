class MunchiesSerializer
  # include FastJsonapi::ObjectSerializer
  # attributes :current_weather, :daily_weather, :hourly_weather
  def self.munchies(object)
    {
      "data": {
        "id": nil,
        "type": 'munchie',
        "attributes": {
          "destination_city": object[:destination_city],
          "travel_time": object[:travel_time],
          "forecast": {
            "summary": object[:forecast][:summary],
            "temperature": object[:forecast][:temperature]
          },
          "restaurant": {
            "name": object[:restaurant][:name],
            "address": object[:restaurant][:address]
          }
        }
      }
    }
  end
end
