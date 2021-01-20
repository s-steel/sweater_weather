class Api::V1::RoadTripController < ApplicationController
  def create
    if find_user.nil?
      json_response({ error: 'Unauthorized' }, status = 401)
    else
      road_trip = RoadTripFacade.road_trip(params[:origin], params[:destination])
      json_response(RoadTripSerializer.road_trip(road_trip))
    end
  end

  private

  def find_user
    User.find_by(api_key: params[:api_key])
  end
end
