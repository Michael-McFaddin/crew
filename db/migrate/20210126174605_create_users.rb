class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :title
      t.string :city
      t.string :state
      t.string :phone
      t.string :profile_img
      t.string :ed
      t.text :desc
      t.integer :coverage_id
      t.string :linkd
      t.string :faceb
      t.string :insta
      t.boolean :active
      t.boolean :admin

      t.timestamps
    end
  end
end
