class CreateEventOlympians < ActiveRecord::Migration[5.2]
  def change
    create_table :event_olympians do |t|
      t.references :event, foreign_key: true
      t.references :olympian, foreign_key: true

      t.timestamps
    end
  end
end
