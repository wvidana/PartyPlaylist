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
    # binding.pry
    @spotify_user
  end

  def spotify
    spotify_user

    # Now you can access user's private data, create playlists and much more

    # Access private data
    # spotify_user.country #=> "US"
    # spotify_user.email   #=> "example@email.com"

    # Create playlist in user's Spotify account
    # playlist = spotify_user.create_playlist!('my-awesome-playlist')

    # Add tracks to a playlist in user's Spotify account
    # tracks = RSpotify::Track.search('Know', limit: 5)
    # playlist.add_tracks!(tracks)
    # playlist.tracks.first.name #=> "Somebody That I Used To Know"

  end

  def playlists
    # Search party playlist
    @playlists = spotify_user.playlists
  end

  def party
    playlist_id = "6o6gzHVTZwcW6u9wNx1K3Y"

    partyplaylist = RSpotify::Playlist.find(spotify_user.id, playlist_id)

    @tracks = partyplaylist.tracks
  end
end