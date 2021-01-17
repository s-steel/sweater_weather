class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location] == ''
      json_response({
                      error: 'City not found, try again with proper params => ex. denver,co'
                    }, status = 404)
    else
      json_response(PhotoSerializer.background_image(PhotoFacade.image_search(params[:location])))
    end
  end
end
