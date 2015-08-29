class CreatePlaylistEntries < ActiveRecord::Migration
  def change
    create_table :playlist_entries do |t|

      t.timestamps null: false
    end
  end
end
