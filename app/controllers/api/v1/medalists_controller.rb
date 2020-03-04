class Api::V1::MedalistsController < ApplicationController
  def index
    event = Event.includes(medalists: [olympian: :team])
                 .order('medalists.medal ASC')
                 .find_by(id: params[:event_id])
    render json: format_payload(event)
  end

  private

  def format_payload(event)
    payload = {
      event: event.name,
      medalists: []
    }
    event.medalists.each do |medalist|
      olympian = {
        name:  medalist.olympian.name,
        team:  medalist.olympian.team.name,
        age:   medalist.olympian.age,
        medal: medalist.medal
      }
      payload[:medalists].push(olympian)
    end
    payload
  end
end