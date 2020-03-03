require 'rails_helper'

describe 'Olympians Index:', type: :request do
  describe 'When I visit /api/v1/olympians' do
    before :each do
      @us    = Team.create!(name: "US")
      @spain = Team.create!(name: "Spain")

      @michael = Olympian.create!(
        name: 'Michael',
        sex: 0,
        age: 29,
        height: 169,
        weight: 68,
        team_id: @us.id
      )
      @veronica = Olympian.create!(
        name: 'Veronica',
        sex: 1,
        age: 32,
        height: 160,
        weight: 50,
        team_id: @spain.id
      )
      @veronica = Olympian.create!(
        name: 'Katie',
        sex: 1,
        age: 26,
        height: 152,
        weight: 52,
        team_id: @us.id
      )
      @ryan = Olympian.create!(
        name: 'Ryan',
        sex: 0,
        age: 29,
        height: 165,
        weight: 91,
        team_id: @us.id
      )
    end
    it 'I get a JSON response with average stats of all olympians in the database' do
      get '/api/v1/olympian_stats'

      
      response = JSON.parse(@response.body, symbolize_names: true)

      expect(@response.status).to eq(200)
      expect(response).to have_key(:olympian_stats)
      expect(response[:olympian_stats]).to be_a(Hash)
      expect(response[:olympian_stats]).to have_key(:total_competing_olympians)
      expect(response[:olympian_stats]).to have_key(:average_weight)
      expect(response[:olympian_stats][:average_weight]).to be_a(Hash)
      expect(response[:olympian_stats][:average_weight]).to have_key(:unit)
      expect(response[:olympian_stats][:average_weight][:unit]).to eq('kg')
      expect(response[:olympian_stats][:average_weight]).to have_key(:male_olympians)
      expect(response[:olympian_stats][:average_weight][:male_olympians]).to eq(79.5)
      expect(response[:olympian_stats][:average_weight]).to have_key(:female_olympians)
      expect(response[:olympian_stats][:average_weight][:female_olympians]).to eq(51)
      expect(response).to have_key(:average_age)
      expect(response[:average_age]).to eq(29)
    end
  end
end