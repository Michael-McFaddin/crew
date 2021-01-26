class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.string :event_name
      t.string :position
      t.text :desc
      t.date :date

      t.timestamps
    end
  end
end
