class PlaylistsController < ApplicationController

  # TODO: Remove this test data
  class TrackDouble < Struct.new(:id, :name, :artist, :album, :duration)
  end

  def show
    @tracks = [
      TrackDouble.new(1, 'Haciendo lo nuestro', 'Doble V', 'Lol', 98765),
      TrackDouble.new(2, 'Otra', 'Doble V', 'Primero', 198765),
      TrackDouble.new(3, 'Tercera', 'Chojin ', 'Lola', 293765),
      TrackDouble.new(4, 'Final!', 'Chojin', '8cho', 134765),
    ]
  end
end
