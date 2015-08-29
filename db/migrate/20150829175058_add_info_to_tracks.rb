class AddInfoToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :title, :string
    add_column :tracks, :artist, :string
    add_column :tracks, :album, :string
    add_column :tracks, :duration, :string
  end
end
