class AddAdminRefToGame < ActiveRecord::Migration
  def change
  	add_column :games, :admin_id, :integer
  end
end
