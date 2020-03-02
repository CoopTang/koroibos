require 'rails_helper'

RSpec.describe Medalist, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :event_id }
    it { should validate_presence_of :olympian_id }
    it { should validate_presence_of :medal }
  end

  describe 'relationships' do
    it { should belong_to :event }
    it { should belong_to :olympian }
  end

  describe 'medals' do
    before :each do
      @event = Event.create(name: 'pole vaulting')
      @olympian = Olympian.create(
        name: 'Michael',
        sex: 0,
        age: 29,
        height: 169,
        weight: 150
      )
    end
    it 'Gold' do
      medalist = Medalist.create(
        event_id: @event.id,
        olympian_id: @olympian.id,
        medal: 0
      )
      expect(medalist.medal).to eq('Gold')
    end

    it 'Silver' do
      medalist = Medalist.create(
        event_id: @event.id,
        olympian_id: @olympian.id,
        medal: 1
      )
      expect(medalist.medal).to eq('Silver')
    end

    it 'Bronze' do
      medalist = Medalist.create(
        event_id: @event.id,
        olympian_id: @olympian.id,
        medal: 2
      )
      expect(medalist.medal).to eq('Bronze')
    end
  end

  describe 'methods' do

  end
end