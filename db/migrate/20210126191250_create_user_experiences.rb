class CreateUserExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :user_experiences do |t|
      t.integer :user_id
      t.integer :experience_id

      t.timestamps
    end
  end
end
