require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    
  end

  describe 'methods' do

  end
end