class SpotifyTrackFind
  include Interactor

  def call
    spoti_track_id = context.spoti_track_id
    if track = RSpotify::Track.find(spoti_track_id)
      context.track = track
    else
      context.fail!(message: "Spotify tracks find failed with spoti_track_id=(#{context.spoti_track_id})")
    end
  end
end
