require 'rails_helper'

describe 'Events Index:', type: :request do
  describe 'When I visit /api/v1/events' do
    before :each do
      @archery = Sport.create!(name: "Archery")
      @archery_event_1 = Event.create!(name: "Archery Men's Individual", sport_id: @archery.id)
      @archery_event_2 = Event.create!(name: "Archery Men's Team", sport_id: @archery.id)
      @archery_event_3 = Event.create!(name: "Archery Women's Individual", sport_id: @archery.id)
      @archery_event_4 = Event.create!(name: "Archery Women's Team", sport_id: @archery.id)

      @badminton  = Sport.create!(name: "Badminton")
      @badminton_event_1 = Event.create!(name: "Badminton Men's Doubles", sport_id: @badminton.id)
      @badminton_event_2 = Event.create!(name: "Badminton Men's Singles", sport_id: @badminton.id)
      @badminton_event_3 = Event.create!(name: "Badminton Women's Doubles", sport_id: @badminton.id)
      @badminton_event_4 = Event.create!(name: "Badminton Women's Singles", sport_id: @badminton.id)
      @badminton_event_5 = Event.create!(name: "Badminton Mixed Doubles", sport_id: @badminton.id)
    end

    it 'I get a JSON response with all events in the database' do
      get '/api/v1/events'
      
      response = JSON.parse(@response.body, symbolize_names: true)
      response[:events] = response[:events].sort_by { |event| event[:sport] }

      expect(@response.status).to eq(200)
      expect(response).to have_key(:events)
      expect(response[:events]).to be_an(Array)
      expect(response[:events].length).to eq(2)

      expect(response[:events][0]).to have_key(:sport)
      expect(response[:events][0][:sport]).to eq('Archery')
      expect(response[:events][0]).to have_key(:events)
      expect(response[:events][0][:events]).to be_an(Array)
      expect(response[:events][0][:events].length).to eq(4)
      expect(response[:events][0][:events].includes?("Archery Men's Individual")).to be(true)
      expect(response[:events][0][:events].includes?("Archery Men's Team")).to be(true)
      expect(response[:events][0][:events].includes?("Archery Women's Individual")).to be(true)
      expect(response[:events][0][:events].includes?("Archery Women's Team")).to be(true)

      expect(response[:events][1]).to have_key(:sport)
      expect(response[:events][1][:sport]).to eq('Archery')
      expect(response[:events][1]).to have_key(:events)
      expect(response[:events][1][:events]).to be_an(Array)
      expect(response[:events][1][:events].length).to eq(5)
      expect(response[:events][1][:events].includes?("Badminton Men's Doubles")).to be(true)
      expect(response[:events][1][:events].includes?("Badminton Men's Singles")).to be(true)
      expect(response[:events][1][:events].includes?("Badminton Women's Doubles")).to be(true)
      expect(response[:events][1][:events].includes?("Badminton Women's Singles")).to be(true)
      expect(response[:events][1][:events].includes?("Badminton Mixed Doubles")).to be(true)
    end
  end
end