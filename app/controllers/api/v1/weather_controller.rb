class Api::V1::WeatherController < ApplicationController
  def index
    location = LocationFacade.city_search(params[:location])
    if params[:location] == '' || location.latitude.nil?
      json_response({
                      error: 'City not found, try again with proper params => ex. denver,co'
                    }, status = 404)
    else
      json_response(ForecastSerializer.forecast(ForecastFacade.city_search(location.latitude, location.longitude, 5,
                                                                           8)))
    end
  end
end
