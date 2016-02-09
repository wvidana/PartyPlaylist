class PlaylistsController < ApplicationController
  
  # Not in routes yet
  def index
    @playlists = spotify_user.playlists
  end

  def show
    @tracks = partyplaylist.tracks
  end

  def update
    partyplaylist.add_tracks!([RSpotify::Track.find(params[:track_id])])
    redirect_to url_for(controller: :playlists, action: :show)
  end

  #####################################
  # Private methods
  #####################################
  private

  def playlist_id
    @spoti_playlist_id = params[:id] || Spoti.credentials['playlist_id']
  end

  def spotify_user
    @spotify_user = RSpotify::User.find(session[:current_user_id])
  end

  def partyplaylist
    RSpotify::Playlist.find(spotify_user.id, playlist_id)
  end
end
