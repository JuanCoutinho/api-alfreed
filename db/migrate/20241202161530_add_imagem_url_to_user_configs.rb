class AddImagemUrlToUserConfigs < ActiveRecord::Migration[7.1]
  def change
    add_column :user_configs, :imagem_url, :string
  end
end
