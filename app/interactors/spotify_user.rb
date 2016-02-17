class SpotifyUser
  include Interactor

  def call
    if user =  ( context.session[:current_user_id] &&
        RSpotify::User.find(context.session[:current_user_id]) ) ||
        RSpotify::User.new(context.auth_hash)
      context.user = user
    else
      context.fail!(message: "Spotify User failed!")
    end
  end
end
