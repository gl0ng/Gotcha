class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
    	t.belongs_to :assassin, index: true
    	t.belongs_to :game, index: true 
    	t.boolean :alive, default: true
    	t.integer :kills, default: 0
    end
  end
end
