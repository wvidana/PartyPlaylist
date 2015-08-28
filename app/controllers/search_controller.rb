class SearchController < ApplicationController
  def index
    query = params[:q]
    @tracks = RSpotify::Track.search(query, limit: 10)
  end
end
