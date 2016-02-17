class PlaylistsController < ApplicationController
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

  private

  def session_params
    { auth_hash: request.env['omniauth.auth'], session: session }
  end

  def playlist_id
    @spoti_playlist_id = params[:id] || Spoti.credentials['playlist_id']
  end

  def get_user
    result = SpotifyUser.call session_params

    if result.success?
      result.user
    else
      flash.now[:message] = t(result.message)
      redirect_to url_for(controller: :welcome, action: :index)
    end
  end

  def spotify_user
    @spotify_user ||= get_user
  end

  def partyplaylist
    RSpotify::Playlist.find(spotify_user.id, playlist_id)
  end
end
