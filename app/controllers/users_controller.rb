class UsersController < ApplicationController
  def spotify
    result = SpotifyUser.call session_params

    session[:current_user_id] = result.id
  end

  private

  def session_params
    { auth_hash:  request.env['omniauth.auth'], session: session }
  end

  # def auth_hash
  #   request.env['omniauth.auth']
  # end

  # def spotify_user
  #   @spotify_user ||= ( session[:current_user_id] &&
  #     RSpotify::User.find(session[:current_user_id]) ) ||
  #     RSpotify::User.new(auth_hash)
  # end
end
