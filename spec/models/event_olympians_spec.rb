require 'rails_helper'

RSpec.describe EventOlympian, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :event_id }
    it { should validate_presence_of :olympian_id }
  end

  describe 'relationships' do
    it { should belong_to :event }
    it { should belong_to :olympian }
  end

  describe 'methods' do

  end
end