require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :olympians }
  end

  describe 'methods' do

  end
end