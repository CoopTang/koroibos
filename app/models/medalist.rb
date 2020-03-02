class Medalist < ApplicationRecord
  validates_presence_of :event_id
  validates_presence_of :olympian_id
  validates_presence_of :medal

  belongs_to :event
  belongs_to :olympian

  enum medal: %w[Gold Silver Bronze]
end