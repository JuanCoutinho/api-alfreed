class AddConfigPdfToUserConfigs < ActiveRecord::Migration[6.0]
    def change
      add_column :user_configs, :config_pdf, :string
    end
  end
  