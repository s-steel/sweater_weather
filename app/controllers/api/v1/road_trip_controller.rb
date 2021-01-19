class Api::V1::RoadTripController < ApplicationController
  def create
    user = find_user
    road_trip = RoadTripFacade.road_trip(params[:origin], params[:destination])
    json_response(RoadTripSerializer.road_trip(road_trip))
  end

  private

  def find_user
    User.find_by!(api_key: params[:api_key])
  rescue StandardError
    json_response( { error: 'Unauthorized' }, status = 401)
  end
end
