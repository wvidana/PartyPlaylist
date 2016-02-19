class ModifySpotifyUser < ActiveRecord::Migration
  def change
    rename_column :users, :spoti_user_id, :spoti_id
  end
end
