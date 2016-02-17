class SpotifyUser
  include Interactor

  def call
    ( context.session[:current_user_id] &&
      RSpotify::User.find(context.session[:current_user_id]) ) ||
      RSpotify::User.new(context.auth_hash)
  end
end