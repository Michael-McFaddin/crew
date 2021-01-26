class CreateCoverages < ActiveRecord::Migration[6.0]
  def change
    create_table :coverages do |t|
      t.string :cover_type

      t.timestamps
    end
  end
end
