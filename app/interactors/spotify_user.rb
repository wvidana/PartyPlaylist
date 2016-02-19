class SpotifyUser
  include Interactor

  def call
    current_user_id = context.session[:current_user_id]
    user = User.find current_user_id
    if spoti_user = RSpotify::User.find(user.spoti_id)
      context.user = spoti_user
    else
      context.fail!(message: "Spotify User failed! with current_user_id=(#{current_user_id})")
    end
  end
end
