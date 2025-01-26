class CreateBanners < ActiveRecord::Migration[7.1]
  def change
    create_table :banners do |t|
      t.string :image
      t.string :link

      t.timestamps
    end
  end
end
