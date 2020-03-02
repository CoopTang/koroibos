class Sport < ApplicationRecord
  validates_presence_of :name

  has_many :sport_olympians
  has_many :olympians, through: :sport_olympians
end