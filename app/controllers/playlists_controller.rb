class PlaylistsController < ApplicationController
  def index
    user = get_user
    if playlist = user.playlist
      redirect_to(action: :show, id: playlist.id)
    else
      @playlists = spotify_user({ spoti_user_id: user.spoti_id }).playlists
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

  def update
    playlist = Playlist.find_by(spoti_id: params[:spoti_playlist_id])

    # Needs to set RSpotify credentials
    user = spotify_user({ spoti_user_id: playlist.user.spoti_id })

    parameters = { spoti_track_id: params[:spoti_track_id],
        spoti_playlist_id: params[:spoti_playlist_id],
        playlist_id: playlist.id }

    update_spotify_playlist(parameters)
    redirect_to url_for(controller: :playlists, action: :show, id: playlist.id)
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

    def update_spotify_playlist(options={})
      result = SpotifyTrackFind.call(session_params.merge(options))
      spoti_track = result.track
      playlist = spotify_playlist(options)
      playlist.add_tracks!([spoti_track])
    end

    def get_user
      User.find session[:current_user_id]
    end

    def spotify_user(options={})
      result = SpotifyUser.call(options)
      if result.success?
        result.user
      else
        flash.now[:message] = t(result.message)
        redirect_to url_for(controller: :welcome, action: :index)
      end
    end

    def spotify_playlist(options={})
      result = SpotifyPlaylist.call session_params.merge(options)
      result.spotify_playlist
    end
end
