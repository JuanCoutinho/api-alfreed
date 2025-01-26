class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.text :embed_code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
