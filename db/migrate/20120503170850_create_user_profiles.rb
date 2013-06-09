class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :nome
      t.string :sobrenome
      t.string :sexo
      t.integer :user_id

      t.timestamps
    end
  end
end
