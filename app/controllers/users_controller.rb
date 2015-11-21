class UsersController < ApplicationController
  def spotify
    session[:current_user_id] = spotify_user.id
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def spotify_user
    @spotify_user ||= ( session[:current_user_id] &&
      RSpotify::User.find(session[:current_user_id]) ) ||
      RSpotify::User.new(auth_hash)
  end
end
