class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    user.authenticate(params[:password])
    json_response(UserSerializer.new(user), status = 200)
  end
end
