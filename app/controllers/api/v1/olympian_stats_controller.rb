class Api::V1::OlympianStatsController < ApplicationController
  
  def show
    stats = Olympian.stats
    render json: format_payload(stats[0].attributes)
  end

  private

  def format_payload(stats)
    {
      olympian_stats: {
        total_competing_olympians: stats['total_competing_olympians'],
        average_weight: {
          unit: 'kg',
          male_olympians: stats['male_olympians'].to_f,
          female_olympians: stats['female_olympians'].to_f
        },
        average_age: stats['average_age'].to_f
      }
    }
  end
end