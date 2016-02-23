class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    user.update(spoti_data: session[:spotify_data])
  end
end
