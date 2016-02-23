class SpotifyTrackFind
  include Interactor

  def call
    spoti_track_id = context.spoti_track_id
    if track = RSpotify::Track.find(spoti_track_id)
      context.track = track
    else
      context.fail!(message: "Spotify tracks search failed with query=(#{context.query})")
    end
  end
end
