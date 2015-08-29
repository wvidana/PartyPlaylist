class AddRelationsToPlaylistEntries < ActiveRecord::Migration
  def change
    add_reference :playlist_entries, :playlist, index: true
    add_reference :playlist_entries, :track, index: true
  end
end
