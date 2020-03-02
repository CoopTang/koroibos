class Olympian < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :sex
  validates_presence_of :age
  validates_presence_of :height
  validates_presence_of :weight

  belongs_to :team
  has_many :sport_olympians
  has_many :sports, through: :sport_olympians
  has_many :event_olympians
  has_many :events, through: :event_olympians
  has_many :medalists

  enum sex: %w[M F]
end