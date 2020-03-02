require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should belong_to :sport }
    it { should have_many :event_olympians }
    it { should have_many(:olympians).through(:event_olympians) }
  end

  describe 'methods' do

  end
end