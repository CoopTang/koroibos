require 'rails_helper'

RSpec.describe Olympian, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :age }
    it { should validate_presence_of :height }
    it { should validate_presence_of :weight }
  end

  describe 'relationships' do
    it { should belong_to :team }
    it { should have_many :sport_olympians }
    it { should have_many(:sports).through(:sport_olympians) }
    it { should have_many :event_olympians }
    it { should have_many(:events).through(:event_olympians) }
    it { should have_many :medalists }
  end

  describe 'sexes' do
    it 'M olympian' do
      team = Team.create(name: 'US')
      olympian = Olympian.create(
        name: 'Michael',
        sex: 0,
        age: 29,
        height: 169,
        weight: 150
      )

      expect(olympian.sex).to eq('M')
    end
    it 'F olympian' do
      team = Team.create(name: 'US')
      olympian = Olympian.create(
        name: 'Katie',
        sex: 1,
        age: 26,
        height: 150,
        weight: 110
      )

      expect(olympian.sex).to eq('F')
    end
  end

  describe 'methods' do
    before :each do
      @us    = Team.create!(name: "US")
      @spain = Team.create!(name: "Spain")

      @sport = Sport.create!(name: "Pole Vaulting")
      @swim  = Sport.create!(name: "Swimming")
      @event = Event.create!(name: "Vauling really high", sport_id: @sport.id)

      @michael = Olympian.create!(
        name: 'Michael',
        sex: 0,
        age: 29,
        height: 169,
        weight: 150,
        team_id: @us.id
      )
      @veronica = Olympian.create!(
        name: 'Veronica',
        sex: 1,
        age: 32,
        height: 160,
        weight: 110,
        team_id: @spain.id
      )
      @ryan = Olympian.create!(
        name: 'Ryan',
        sex: 0,
        age: 29,
        height: 165,
        weight: 200,
        team_id: @us.id
      )

      @michael_sport = SportOlympian.create!(sport_id: @sport.id, olympian_id: @michael.id)
      @veronica_sport = SportOlympian.create!(sport_id: @sport.id, olympian_id: @veronica.id)
      @ryan_sport = SportOlympian.create!(sport_id: @swim.id, olympian_id: @ryan.id)

      @michael_event = EventOlympian.create!(event_id: @event.id, olympian_id: @michael.id)
      @veronica_event = EventOlympian.create!(event_id: @event.id, olympian_id: @veronica.id)
      @ryan_event = EventOlympian.create!(event_id: @event.id, olympian_id: @ryan.id)

      @veronica_medalist = Medalist.create!(event_id: @event.id, olympian_id: @veronica.id, medal: 0)
      @michael_medalist = Medalist.create!(event_id: @event.id, olympian_id: @michael.id, medal: 1)
    end
    it '::all_with_medals' do
      olympians = Olympian.all_with_medals
      results = { results: olympians.map(&:attributes) }.to_json
      results = JSON.parse(results, symbolize_names: true)
      results = results[:results].sort_by { |result| result[:name] }

      expect(results).to be_an(Array)
      expect(results.length).to eq(3)

      expect(results[0]).to have_key(:name)
      expect(results[0][:name]).to eq('Michael')
      expect(results[0]).to have_key(:team)
      expect(results[0][:team]).to eq('US')
      expect(results[0]).to have_key(:age)
      expect(results[0][:age]).to eq(29)
      expect(results[0]).to have_key(:sport)
      expect(results[0][:sport]).to eq('Pole Vaulting')
      expect(results[0]).to have_key(:total_medals_won)
      expect(results[0][:total_medals_won]).to eq(1)

      expect(results[1]).to have_key(:name)
      expect(results[1][:name]).to eq('Ryan')
      expect(results[1]).to have_key(:team)
      expect(results[1][:team]).to eq('US')
      expect(results[1]).to have_key(:age)
      expect(results[1][:age]).to eq(29)
      expect(results[1]).to have_key(:sport)
      expect(results[1][:sport]).to eq('Swimming')
      expect(results[1]).to have_key(:total_medals_won)
      expect(results[1][:total_medals_won]).to eq(0)

      expect(results[2]).to have_key(:name)
      expect(results[2][:name]).to eq('Veronica')
      expect(results[2]).to have_key(:team)
      expect(results[2][:team]).to eq('Spain')
      expect(results[2]).to have_key(:age)
      expect(results[2][:age]).to eq(32)
      expect(results[2]).to have_key(:sport)
      expect(results[2][:sport]).to eq('Pole Vaulting')
      expect(results[2]).to have_key(:total_medals_won)
      expect(results[2][:total_medals_won]).to eq(1)
    end

    it '::youngest' do
      olympians = Olympian.youngest
      results = { results: olympians.map(&:attributes) }.to_json
      results = JSON.parse(results, symbolize_names: true)
      results = results[:results].sort_by { |result| result[:name] }

      expect(results).to be_an(Array)
      expect(results.length).to eq(2)

      expect(results[0]).to have_key(:name)
      expect(results[0][:name]).to eq('Michael')
      expect(results[0]).to have_key(:team)
      expect(results[0][:team]).to eq('US')
      expect(results[0]).to have_key(:age)
      expect(results[0][:age]).to eq(29)
      expect(results[0]).to have_key(:sport)
      expect(results[0][:sport]).to eq('Pole Vaulting')
      expect(results[0]).to have_key(:total_medals_won)
      expect(results[0][:total_medals_won]).to eq(1)

      expect(results[1]).to have_key(:name)
      expect(results[1][:name]).to eq('Ryan')
      expect(results[1]).to have_key(:team)
      expect(results[1][:team]).to eq('US')
      expect(results[1]).to have_key(:age)
      expect(results[1][:age]).to eq(29)
      expect(results[1]).to have_key(:sport)
      expect(results[1][:sport]).to eq('Swimming')
      expect(results[1]).to have_key(:total_medals_won)
      expect(results[1][:total_medals_won]).to eq(0)
    end

    it '::oldest' do
      olympians = Olympian.oldest
      results = { results: olympians.map(&:attributes) }.to_json
      results = JSON.parse(results, symbolize_names: true)
      results = results[:results].sort_by { |result| result[:name] }

      expect(results).to be_an(Array)
      expect(results.length).to eq(1)

      expect(results[0]).to have_key(:name)
      expect(results[0][:name]).to eq('Veronica')
      expect(results[0]).to have_key(:team)
      expect(results[0][:team]).to eq('Spain')
      expect(results[0]).to have_key(:age)
      expect(results[0][:age]).to eq(32)
      expect(results[0]).to have_key(:sport)
      expect(results[0][:sport]).to eq('Pole Vaulting')
      expect(results[0]).to have_key(:total_medals_won)
      expect(results[0][:total_medals_won]).to eq(1)
    end
  end
end