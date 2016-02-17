class UsersController < ApplicationController
  def spotify
    result = SpotifyUser.call session_params

    session[:current_user_id] = result.user.id
  end

  private

  def session_params
    { auth_hash: request.env['omniauth.auth'], session: session }
  end
end
