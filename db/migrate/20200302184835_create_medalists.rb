class CreateMedalists < ActiveRecord::Migration[5.2]
  def change
    create_table :medalists do |t|
      t.references :event, foreign_key: true
      t.references :olympian, foreign_key: true
      t.integer :medal

      t.timestamps
    end
  end
end
