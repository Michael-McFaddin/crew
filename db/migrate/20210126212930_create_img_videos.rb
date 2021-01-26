class CreateImgVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :img_videos do |t|
      t.integer :user_id
      t.string :url
      t.string :media_type

      t.timestamps
    end
  end
end
