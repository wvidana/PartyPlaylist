class SpotifyToken
  include Interactor

  def call
    if user = User.find context.user_id
      context.token = user.spoti_data['credentials']['token']
    else
      context.fail!(message: "Spotify Playlist failed with playlist_id=(#{context.playlist_id})")
    end
  end
end
