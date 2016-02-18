class AddSpotiUser < ActiveRecord::Migration
  def change
    add_column :users, :spoti_user_id, :string
  end
end
