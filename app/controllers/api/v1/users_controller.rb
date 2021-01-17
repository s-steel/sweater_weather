class Api::V1::UsersController < ApplicationController
  def create
    require 'pry', binding.pry

    @user = User.new(user_params)
    if @user.valid?
      @user.save
      flash[:success] = 'You have successfully registered!'
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end
    # if params[:location] == ''
    #   json_response({
    #                   error: 'City not found, try again with proper params => ex. denver,co'
    #                 }, status = 404)
    # else
    #   json_response(PhotoSerializer.background_image(PhotoFacade.image_search(params[:location])))
    # end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
