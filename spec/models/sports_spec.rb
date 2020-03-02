require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :sport_olympians }
    it { should have_many(:olympians).through(:sport_olympians) }
    
  end

  describe 'methods' do

  end
end