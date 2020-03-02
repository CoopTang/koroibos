require 'rails_helper'

describe 'Olympians Index:', type: :request do
  describe 'When I visit /api/v1/olympians' do
    before :each do
      @us    = Team.create!(name: "US")
      @spain = Team.create!(name: "Spain")

      @sport = Sport.create!(name: "Pole Vaulting")
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

      @michael_sport = SportOlympian.create!(sport_id: @sport.id, olympian_id: @michael.id)
      @veronica_sport = SportOlympian.create!(sport_id: @sport.id, olympian_id: @veronica.id)

      @michael_event = EventOlympian.create!(event_id: @sport.id, olympian_id: @michael.id)
      @veronica_event = EventOlympian.create!(event_id: @sport.id, olympian_id: @veronica.id)

      @medalist = Medalist.create!(event_id: @event.id, olympian_id: @veronica.id, medal: 0)
    end
    it 'I get a JSON response with all olympians in the database', :vcr do
      get '/api/v1/olympians'

      expect(response).to have_key(:olympians)
      expect(response[:olympians]).to be_an(Array)
      expect(response[:olympians].length).to be_an(2)
      expect(response[:olympians][0]).to have_key(:name)
      expect(response[:olympians][0].name).to eq('Michael')
      expect(response[:olympians][0]).to have_key(:team)
      expect(response[:olympians][0].team).to eq('US')
      expect(response[:olympians][0]).to have_key(:age)
      expect(response[:olympians][0].age).to eq(29)
      expect(response[:olympians][0]).to have_key(:sport)
      expect(response[:olympians][0].sport).to eq('Pole Vaulting')
      expect(response[:olympians][0]).to have_key(:total_medals_won)
      expect(response[:olympians][0].total_medals_won).to eq(0)

      expect(response[:olympians][1]).to have_key(:name)
      expect(response[:olympians][1].name).to eq('Veronica')
      expect(response[:olympians][1]).to have_key(:team)
      expect(response[:olympians][1].team).to eq('Spain')
      expect(response[:olympians][1]).to have_key(:age)
      expect(response[:olympians][1].age).to eq(32)
      expect(response[:olympians][1]).to have_key(:sport)
      expect(response[:olympians][1].sport).to eq('Pole Vaulting')
      expect(response[:olympians][1]).to have_key(:total_medals_won)
      expect(response[:olympians][1].total_medals_won).to eq(1)
    end
  end
end