class AddReferencesToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :snapshot_id, :string
    add_column :playlists, :href, :string
  end
end
