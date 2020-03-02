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

  end
end