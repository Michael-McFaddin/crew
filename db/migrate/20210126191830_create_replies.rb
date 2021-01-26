class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :message_id
      t.text :replytext

      t.timestamps
    end
  end
end
