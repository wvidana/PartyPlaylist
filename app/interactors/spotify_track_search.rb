class SpotifyTrackSearch
  include Interactor

  def call
    query = context.q
    if tracks = RSpotify::Track.search(query, limit: 10)
      context.tracks = tracks
    else
      context.fail!(message: "Spotify tracks search failed with query=(#{context.query})")
    end
  end
end
