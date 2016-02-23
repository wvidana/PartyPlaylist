class SpotifyPlaylist
  include Interactor

  def call
    playlist = Playlist.find(context.playlist_id)
    if spotify_playlist = RSpotify::Playlist.find(playlist.user.spoti_id, playlist.spoti_id) 
      context.spotify_playlist = spotify_playlist
    else
      context.fail!(message: "Spotify Playlist failed with playlist_id=(#{context.playlist_id})")
    end
  end
end
