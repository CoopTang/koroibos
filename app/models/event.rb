class Event < ApplicationRecord
  validates_presence_of :name

  belongs_to :sport
  has_many :event_olympians
  has_many :olympians, through: :event_olympians
end