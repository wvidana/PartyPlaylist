class AddSpotiuriToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :spoti_uri, :string
  end
end
