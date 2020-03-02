class EventOlympian < ApplicationRecord
  validates_presence_of :event_id
  validates_presence_of :olympian_id

  belongs_to :event
  belongs_to :olympian
end