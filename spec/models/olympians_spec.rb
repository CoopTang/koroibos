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
  end

  describe 'methods' do

  end
end