require 'rails_helper'

describe 'Olympians Index:', type: :request do
  describe 'When I visit /api/v1/olympians' do
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
    it 'I get a JSON response with all olympians in the database' do
      get '/api/v1/olympians'

      
      response = JSON.parse(@response.body, symbolize_names: true)
      response[:olympians] = response[:olympians].sort_by { |olympian| olympian[:name] }

      expect(@response.status).to eq(200)
      expect(response).to have_key(:olympians)
      expect(response[:olympians]).to be_an(Array)
      expect(response[:olympians].length).to eq(3)

      expect(response[:olympians][0]).to have_key(:name)
      expect(response[:olympians][0][:name]).to eq('Michael')
      expect(response[:olympians][0]).to have_key(:team)
      expect(response[:olympians][0]).to have_key(:age)
      expect(response[:olympians][0][:age]).to eq(29)
      expect(response[:olympians][0]).to have_key(:sport)
      expect(response[:olympians][0][:sport]).to eq('Pole Vaulting')
      expect(response[:olympians][0]).to have_key(:total_medals_won)
      expect(response[:olympians][0][:total_medals_won]).to eq(1)
      
      expect(response[:olympians][1][:name]).to eq('Ryan')
      expect(response[:olympians][1][:team]).to eq('US')
      expect(response[:olympians][1][:age]).to eq(29)
      expect(response[:olympians][1][:sport]).to eq('Swimming')
      expect(response[:olympians][1][:total_medals_won]).to eq(0)

      expect(response[:olympians][2][:name]).to eq('Veronica')
      expect(response[:olympians][2][:team]).to eq('Spain')
      expect(response[:olympians][2][:age]).to eq(32)
      expect(response[:olympians][2][:sport]).to eq('Pole Vaulting')
      expect(response[:olympians][2][:total_medals_won]).to eq(1)
    end

    it 'I get a JSON response with the youngest olympians in the database' do
      get '/api/v1/olympians?age=youngest'

      response = JSON.parse(@response.body, symbolize_names: true)
      response[:olympians] = response[:olympians].sort_by { |olympian| olympian[:name] }

      expect(@response.status).to eq(200)
      expect(response).to have_key(:olympians)
      expect(response[:olympians]).to be_an(Array)
      expect(response[:olympians].length).to eq(2)

      expect(response[:olympians][0]).to have_key(:name)
      expect(response[:olympians][0][:name]).to eq('Michael')
      expect(response[:olympians][0]).to have_key(:team)
      expect(response[:olympians][0][:team]).to eq('US')
      expect(response[:olympians][0]).to have_key(:age)
      expect(response[:olympians][0][:age]).to eq(29)
      expect(response[:olympians][0]).to have_key(:sport)
      expect(response[:olympians][0][:sport]).to eq('Pole Vaulting')
      expect(response[:olympians][0]).to have_key(:total_medals_won)
      expect(response[:olympians][0][:total_medals_won]).to eq(1)

      expect(response[:olympians][1]).to have_key(:name)
      expect(response[:olympians][1][:name]).to eq('Ryan')
      expect(response[:olympians][1]).to have_key(:team)
      expect(response[:olympians][1][:team]).to eq('US')
      expect(response[:olympians][1]).to have_key(:age)
      expect(response[:olympians][1][:age]).to eq(29)
      expect(response[:olympians][1]).to have_key(:sport)
      expect(response[:olympians][1][:sport]).to eq('Swimming')
      expect(response[:olympians][1]).to have_key(:total_medals_won)
      expect(response[:olympians][1][:total_medals_won]).to eq(0)
    end

    it 'I get a JSON response with the oldest olympians in the database' do
      get '/api/v1/olympians?age=oldest'

      response = JSON.parse(@response.body, symbolize_names: true)
      response[:olympians] = response[:olympians].sort_by { |olympian| olympian[:name] }

      expect(@response.status).to eq(200)
      expect(response).to have_key(:olympians)
      expect(response[:olympians]).to be_an(Array)
      expect(response[:olympians].length).to eq(1)

      expect(response[:olympians][0]).to have_key(:name)
      expect(response[:olympians][0][:name]).to eq('Veronica')
      expect(response[:olympians][0]).to have_key(:team)
      expect(response[:olympians][0][:team]).to eq('Spain')
      expect(response[:olympians][0]).to have_key(:age)
      expect(response[:olympians][0][:age]).to eq(32)
      expect(response[:olympians][0]).to have_key(:sport)
      expect(response[:olympians][0][:sport]).to eq('Pole Vaulting')
      expect(response[:olympians][0]).to have_key(:total_medals_won)
      expect(response[:olympians][0][:total_medals_won]).to eq(1)
    end

    it 'returns an error message if age is not youngest' do
      get '/api/v1/olympians?age=asdf'

      response = JSON.parse(@response.body, symbolize_names: true)
      
      expect(@response.status).to eq(400)
      expect(response).to have_key(:message)
      expect(response[:message]).to eq("Age must be 'youngest' or 'oldest'!")
    end
  end
end