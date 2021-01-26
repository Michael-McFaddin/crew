class CreateCalendars < ActiveRecord::Migration[6.0]
  def change
    create_table :calendars do |t|
      t.string :avail
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
