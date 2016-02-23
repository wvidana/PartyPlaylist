class ChangeSpotidataInUserToJson < ActiveRecord::Migration
  def change
    change_column :users, :spoti_data, 'json USING spoti_data::json'
  end
end
