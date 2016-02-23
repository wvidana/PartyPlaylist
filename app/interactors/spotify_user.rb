class SpotifyUser
  include Interactor

  def call
    rspotify_hash = context.rspotify_hash ||
        User.find_by(spoti_id: context.spoti_user_id).spoti_data
    if spoti_user = RSpotify::User.new(rspotify_hash)
      context.user = spoti_user
    else
      context.fail!(message: "Spotify User failed! with current_user_id=(#{current_user_id})")
    end
  end
end
