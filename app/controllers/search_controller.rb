class SearchController < ApplicationController
  def index
    @tracks = SpotifyTrackSearch.call session_params
  end

  private
    def session_params
      { session: session, q: params[:q] }
    end
end
