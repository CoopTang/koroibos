class SportOlympian < ApplicationRecord
  validates_presence_of :sport_id
  validates_presence_of :olympian_id

  belongs_to :sport
  belongs_to :olympian
end