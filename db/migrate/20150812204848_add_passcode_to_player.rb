class AddPasscodeToPlayer < ActiveRecord::Migration
  def change
  	add_column :players, :passcode, :string
  end
end
