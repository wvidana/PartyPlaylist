require 'pry'

class UsersController < ApplicationController
  def spotify_user
    user_hash = request.env['omniauth.auth']
    if user_hash.nil?
      @spotify_user = RSpotify::User.find(session[:current_user_id])
    else
      @spotify_user = RSpotify::User.new(user_hash)
      session[:current_user_id] = @spotify_user.id
    end
    @spotify_user
  end

  def spotify
    spotify_user

  end

  def playlists
    # Search party playlist
    @playlists = spotify_user.playlists
  end

  def add_song
    partyplaylist.add_tracks!([RSpotify::Track.find(params[:track_id])])
    redirect_to url_for(controller: :users, action: :party)
  end

  def party
    @tracks = partyplaylist.tracks
  end

  def partyplaylist
    playlist_id = "6o6gzHVTZwcW6u9wNx1K3Y"
    RSpotify::Playlist.find(spotify_user.id, playlist_id)
  end

end
