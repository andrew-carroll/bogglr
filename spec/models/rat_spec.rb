require 'rails_helper'

RSpec.describe Rat, type: :model do
  fixtures :rats, :users, :rat_users
  before do
    Timecop.freeze(Time.local(2023,3,21,9,30,00))
  end

  after do
    Timecop.return
  end

  it { should have_many :caretakers }

  describe '#caretaker' do
    it 'returns the first associated user' do
      expect(rats(:fred).caretaker).to eq(rats(:fred).caretakers.first)
    end
  end

  describe '#age' do
    context 'when crossed_rainbow_bridge' do
      it 'returns the age in months of the rat when it crossed the rainbow bridge' do
        expect(rats(:fred).age).to eq(32)
      end
    end
    context 'when not crossed_rainbow_bridge' do
      it 'returns the current age in months of the rat' do
        expect(rats(:gemma).age).to eq(12)
      end
    end
  end

  describe '#crossed_rainbow_bridge?' do
    it 'returns true iff crossed_rainbow_bridge_at is not nil' do
      expect(rats(:fred).crossed_rainbow_bridge?).to eq(true)
      expect(rats(:gemma).crossed_rainbow_bridge?).to eq(false)
    end
  end
end
