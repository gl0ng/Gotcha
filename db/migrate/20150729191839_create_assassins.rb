class CreateAssassins < ActiveRecord::Migration
  def change
    create_table :assassins do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :admin, :default => false

      t.timestamps null: false
    end
  end
end
