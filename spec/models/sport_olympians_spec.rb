require 'rails_helper'

RSpec.describe SportOlympian, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :sport_id }
    it { should validate_presence_of :olympian_id }
  end

  describe 'relationships' do
    it { should belong_to :sport }
    it { should belong_to :olympian }
  end

  describe 'methods' do

  end
end