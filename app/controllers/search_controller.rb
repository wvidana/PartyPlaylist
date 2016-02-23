class SearchController < ApplicationController
  def index
    @spoti_playlist_id = params[:spoti_playlist_id]
    @tracks = SpotifyTrackSearch.call(session_params).tracks
  end

  private
    def session_params
      { session: session, q: params[:q] }
    end
end
