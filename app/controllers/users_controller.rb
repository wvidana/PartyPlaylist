class UsersController < ApplicationController
  def spotify_user
    user_hash = request.env['omniauth.auth']
    if user_hash.nil?
      @spotify_user = RSpotify::User.find(session[:current_user_id])
    else
      @spotify_user = RSpotify::User.new(user_hash)
      session[:current_user_id] = @spotify_user.id
    end
    @spotify_user
  end

  def spotify
    spotify_user

  end

end
