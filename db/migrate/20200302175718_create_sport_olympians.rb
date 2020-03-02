class CreateSportOlympians < ActiveRecord::Migration[5.2]
  def change
    create_table :sport_olympians do |t|
      t.references :sport, foreign_key: true
      t.references :olympian, foreign_key: true

      t.timestamps
    end
  end
end
