class ChangeSpotiDataInUserToText < ActiveRecord::Migration
  def change
    change_column :users, :spoti_data, :text
  end
end
