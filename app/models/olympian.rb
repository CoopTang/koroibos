class Olympian < ApplicationRecord
  serialize :preferences, JSON

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

  def self.all_with_medals
    select('
      olympians.name, 
      olympians.sex, 
      olympians.age, 
      teams.name as team, 
      sports.name as sport, 
      COUNT(medalists.*) AS total_medals_won
    ')
    .joins(:team, :sports)
    .left_joins(:medalists)
    .group('olympians.id, teams.name, sports.name')
  end

  def self.youngest
    select('
      olympians.name, 
      olympians.sex, 
      olympians.age, 
      teams.name as team, 
      sports.name as sport, 
      COUNT(medalists.*) AS total_medals_won
    ')
    .joins(:team, :sports)
    .left_joins(:medalists)
    .group('olympians.id, teams.name, sports.name')
    .where(age: Olympian.minimum(:age))
  end

  def self.oldest    
    select('
      olympians.name, 
      olympians.sex, 
      olympians.age, 
      teams.name as team, 
      sports.name as sport, 
      COUNT(medalists.*) AS total_medals_won
    ')
    .joins(:team, :sports)
    .left_joins(:medalists)
    .group('olympians.id, teams.name, sports.name')
    .where(age: Olympian.maximum(:age))
  end
end