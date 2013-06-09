class CreateAmigos < ActiveRecord::Migration
  def change
    create_table :amigos do |t|
      t.integer :user_profile_id
      t.integer :amigo_id
      t.string :status

      t.timestamps
    end
  end
end
