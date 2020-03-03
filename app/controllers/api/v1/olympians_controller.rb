class Api::V1::OlympiansController < ApplicationController

  def index
    olympians = Olympian.all_with_medals
    response = { olympians: parse_olympians(olympians) }
    render json: response
  end

  private

  def parse_olympians(olympians)
    olympians.map do |olympian|
      olympian.attributes.reject! { |k, v| v.nil? }
    end
  end
end