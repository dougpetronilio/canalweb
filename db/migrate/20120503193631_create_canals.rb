class CreateCanals < ActiveRecord::Migration
  def change
    create_table :canals do |t|
      t.string :nome
      t.string :tipo_programacao
      t.integer :idade_minima
      t.string :imagem
      t.text :descricao
      t.integer :user_id

      t.timestamps
    end
  end
end
