class PlaylistsController < ApplicationController
  def index
    user = get_user
    if playlist = user.playlist
      redirect_to(action: :show, id: playlist.id)
    else
      @playlists = spotify_user.playlists
    end
  end

  def show
    if playlist = Playlist.find(params[:id])
      @spoti_playlist_id = playlist.spoti_id
      @tracks = spotify_playlist.tracks
    else
      puts "NO PLAYLIST FOUND IN DB"
      redirect_to url_for(controller: :playlists, action: :index)
    end
  end

  # Pending revision...
  def update
    partyplaylist.add_tracks!([RSpotify::Track.find(params[:track_id])])
    redirect_to url_for(controller: :playlists, action: :show)
  end

  def assign_user
    user = get_user
    Playlist.create(spoti_id: params[:spoti_id], user_id: user.id)
    playlist = Playlist.find_by(spoti_id: params[:spoti_id])
    redirect_to url_for(controller: :playlists, action: :show, id: playlist.id)
  end

  private

    def session_params
      { session: session , playlist_id: params[:id] }
    end

    def get_user
      User.find session[:current_user_id]
    end

    def get_user_from_spotify
      result = SpotifyUser.call session_params
      if result.success?
        result.user
      else
        flash.now[:message] = t(result.message)
        redirect_to url_for(controller: :welcome, action: :index)
      end
    end

    def spotify_user
      @spotify_user ||= get_user_from_spotify
    end

    def spotify_playlist
      result = SpotifyPlaylist.call session_params
      result.spotify_playlist
    end
end
