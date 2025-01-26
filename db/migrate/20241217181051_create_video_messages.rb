class CreateVideoMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :video_messages do |t|
      t.string :content
      t.references :video, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
