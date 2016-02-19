class PlaylistsController < ApplicationController
  def index
    @playlists = spotify_user.playlists
  end

  def show
    if params.key?(:id)
      @tracks = partyplaylist.tracks
    else
      puts "NO PLAYLIST ID!!!"
      redirect_to url_for(controller: :playlists, action: :index)
    end
  end

  # Pending revision...
  def update
    partyplaylist.add_tracks!([RSpotify::Track.find(params[:track_id])])
    redirect_to url_for(controller: :playlists, action: :show)
  end

  def assign_user
    user = User.find session[:current_user_id]
    Playlist.create(spoti_id: params[:spoti_id], user_id: user.id)
    playlist = Playlist.find_by(spoti_id: params[:spoti_id])
    redirect_to url_for(controller: :playlists, action: :show, id: playlist.id)
  end

  private

  def session_params
    { session: session , playlist_id: params[:id] }
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
