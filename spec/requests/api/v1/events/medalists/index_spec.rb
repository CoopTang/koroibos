require 'rails_helper'

describe 'Event Medalists Index:', type: :request do
  describe 'When I visit /api/v1/events/:id/medalists' do
    before :each do
      @archery = Sport.create!(name: "Archery")
      @archery_event_1 = Event.create!(name: "Archery Men's Individual", sport_id: @archery.id)

      @badminton  = Sport.create!(name: "Badminton")
      @badminton_event_1 = Event.create!(name: "Badminton Men's Doubles", sport_id: @badminton.id)

      @us    = Team.create!(name: "US")
      @spain = Team.create!(name: "Spain")

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

      @michael_sport  = SportOlympian.create!(sport_id: @archery.id, olympian_id: @michael.id)
      @veronica_sport = SportOlympian.create!(sport_id: @archery.id, olympian_id: @veronica.id)
      @ryan_sport     = SportOlympian.create!(sport_id: @badminton.id, olympian_id: @ryan.id)

      @michael_event  = EventOlympian.create!(event_id: @archery_event_1.id, olympian_id: @michael.id)
      @veronica_event = EventOlympian.create!(event_id: @archery_event_1.id, olympian_id: @veronica.id)
      @ryan_event     = EventOlympian.create!(event_id: @badminton_event_1.id, olympian_id: @ryan.id)

      @veronica_medalist = Medalist.create!(event_id: @archery_event_1.id, olympian_id: @veronica.id, medal: 0)
      @michael_medalist  = Medalist.create!(event_id: @archery_event_1.id, olympian_id: @michael.id, medal: 1)
      @ryan_medalist     = Medalist.create!(event_id: @badminton_event_1.id, olympian_id: @ryan.id, medal: 2)
    end

    it 'I get a JSON response with all events in the database' do
      get "/api/v1/events/#{@archery_event_1.id}/medalists"
      
      response = JSON.parse(@response.body, symbolize_names: true)

      expect(@response.status).to eq(200)
      expect(response).to have_key(:event)
      expect(response[:event]).to eq("Archery Men's Individual")
      expect(response[:event][:medalists]).to be_an(Array)
      expect(response[:event][:medalists].length).to eq(2)
      
      expect(response[:event][:medalists][0]).to have_key(:name)
      expect(response[:event][:medalists][0][:name]).to eq('Veronica')
      expect(response[:event][:medalists][0]).to have_key(:team)
      expect(response[:event][:medalists][0][:team]).to eq('Spain')
      expect(response[:event][:medalists][0]).to have_key(:age)
      expect(response[:event][:medalists][0][:age]).to eq(32)
      expect(response[:event][:medalists][0]).to have_key(:medal)
      expect(response[:event][:medalists][0][:medal]).to eq('Gold')

      expect(response[:event][:medalists][1][:name]).to eq('Michael')
      expect(response[:event][:medalists][1][:team]).to eq('US')
      expect(response[:event][:medalists][1][:age]).to eq(29)
      expect(response[:event][:medalists][1][:medal]).to eq('Silver')
    end
  end
end