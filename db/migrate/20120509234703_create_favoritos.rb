class CreateFavoritos < ActiveRecord::Migration
  def change
    create_table :favoritos do |t|
      t.integer :user_profile_id
      t.integer :canal_id

      t.timestamps
    end
  end
end
