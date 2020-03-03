class Api::V1::OlympiansController < ApplicationController

  def index
    response = params.has_key?(:age) ? age_response : all_response
    status   = response.has_key?(:message) ? 400 : 200
    render json: response, status: status
  end

  private

  def parse_olympians(olympians)
    parsed = olympians.map do |olympian|
      olympian.attributes.reject! { |k, v| v.nil? }
    end
    { olympians: parsed }
  end

  def all_response
    parse_olympians(Olympian.all_with_medals)
  end

  def age_response
    case params[:age]
    when 'youngest'
      parse_olympians(Olympian.youngest)
    when 'oldest'
      binding.pry
    else
      { message: "Age must be 'youngest' or 'oldest'!" } 
    end
  end

end