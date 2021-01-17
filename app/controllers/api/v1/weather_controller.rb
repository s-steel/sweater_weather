class Api::V1::WeatherController < ApplicationController
  def index
    location = LocationFacade.city_search(params[:location])
    render json: ForecastSerializer.forecast(ForecastFacade.city_search(location.latitude, location.longitude))
  end
end
