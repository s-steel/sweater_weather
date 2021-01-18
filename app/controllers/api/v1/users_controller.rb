class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    json_response(UserSerializer.new(user), :created)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
