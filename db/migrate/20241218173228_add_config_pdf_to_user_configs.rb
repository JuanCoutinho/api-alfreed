class AddConfigPdfToUserConfigs < ActiveRecord::Migration[7.1]
  def change
    add_column :user_configs, :config_pdf, :string
  end
end
