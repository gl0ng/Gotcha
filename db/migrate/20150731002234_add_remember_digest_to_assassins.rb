class AddRememberDigestToAssassins < ActiveRecord::Migration
  def change
    add_column :assassins, :remember_digest, :string
  end
end
