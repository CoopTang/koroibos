class AddOlympians < ActiveRecord::Migration[5.2]
  def change
    create_table :olympians do |t|
      t.string :name
      t.integer :sex, default: 0
      t.integer :age
      t.integer :height
      t.integer :weight
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
