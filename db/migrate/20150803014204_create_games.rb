class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :assassin, index: true
      t.string :name
      t.text   :description
      t.boolean :in_progress, default: false
      t.boolean :finished,    default: false
      t.timestamps null: false
    end
  end
end
