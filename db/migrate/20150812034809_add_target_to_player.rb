class AddTargetToPlayer < ActiveRecord::Migration
  def change
  	add_column :players, :target_id, :integer
  	add_index :players, :target_id
  end
end
