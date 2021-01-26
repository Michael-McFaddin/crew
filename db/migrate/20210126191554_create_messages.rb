class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
