class AddTargetToPlayer < ActiveRecord::Migration
  def change
  	add_column :players, :target_id, :integer
  end
end
