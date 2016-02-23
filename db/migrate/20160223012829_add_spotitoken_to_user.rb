class AddSpotitokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :spoti_data, :string
  end
end
