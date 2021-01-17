class Api::V1::UsersController < ApplicationController
  def create

    user = User.new(user_params)
require 'pry', binding.pry
    user.save!
    json_response(UserSerializer.new(user), status = 201)
  rescue StandardError
    json_response(UserFailedSerializer.new(user), status = 404)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
