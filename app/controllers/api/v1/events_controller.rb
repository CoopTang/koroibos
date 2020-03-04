class Api::V1::EventsController < ApplicationController
  def index
    sports = Sport.includes(:events)
    render json: format_payload(sports)
  end

  private

  def format_payload(sports)
    payload = {
      events: []
    }
    sports.each do |sport|
      sport = { sport: sport.name, events: sport.events.pluck(:name) }
      payload[:events].push(sport)
    end
    payload
  end
end