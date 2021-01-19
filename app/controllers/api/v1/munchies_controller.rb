class Api::V1::MunchiesController < ApplicationController
  def index
    munchies_response = MunchiesFacade.restaurant_search(params[:start], params[:end], params[:food])
    json_response(MunchiesSerializer.munchies(munchies_response))
  end
end