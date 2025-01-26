class CreateUserConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :user_configs do |t|
      t.string :nome_bot
      t.string :temperatura
      t.string :finalidade
      t.string :user_name
      t.json :base_de_dados
      t.json :estrutura_desejo
      t.json :exemplo_referencia
      t.json :input
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
