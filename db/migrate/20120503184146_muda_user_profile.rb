class MudaUserProfile < ActiveRecord::Migration
  def up
    add_column :user_profiles, :nascimento, :date
    add_column :user_profiles, :pais, :string
    add_column :user_profiles, :estado, :string
    add_column :user_profiles, :cidade, :string
    add_column :user_profiles, :cep, :string

  end

  def down
    remove_column :user_profiles, :nascimento
    remove_column :user_profiles, :pais
    remove_column :user_profiles, :estado
    remove_column :user_profiles, :cidade
    remove_column :user_profiles, :cep
  end
end
