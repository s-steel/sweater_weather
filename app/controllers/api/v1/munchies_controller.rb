class Api::V1::MunchiesController < ApplicationController
  def index
    # if params[:location] == ''
    #   json_response({
    #                   error: 'City not found, try again with proper params => ex. denver,co'
    #                 }, status = 404)
    # else
    #   location = LocationFacade.city_search(params[:location])
    #   json_response(ForecastSerializer.forecast(ForecastFacade.city_search(location.latitude, location.longitude)))
    # end
  end
end