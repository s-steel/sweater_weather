class Api::V1::SessionsController < ApplicationController
  def create
    user = find_user
    if user.authenticate(params[:password])
      json_response(UserSerializer.new(user), status = 200)
    else
      json_response({ error: 'Invalid email or password, please try again.' }, status = 401)
    end
  end

  private

  def find_user
    User.find_by!(email: params[:email])
  rescue StandardError
    json_response(UserSerializer.new(user))
  end
end
