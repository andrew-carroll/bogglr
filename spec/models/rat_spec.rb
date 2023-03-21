require 'rails_helper'

RSpec.describe Rat, type: :model do
  before do
    @user = User.create!(
      username: "acarroll",
      email: "acarroll@bogglr.com",
      password: "hunter2",
      password_confirmation: "hunter2",
      confirmed_at: Time.now
    )
    @rat = @user.rats.create!(
      name: "Fred",
      sex: :male,
      approx_birthday: Date.new(2018,2,1),
      crossed_rainbow_bridge_at: Date.new(2020, 10, 29)
    )
    @rat2 = @user.rats.create!(
      name: "Gemma",
      sex: :female,
      approx_birthday: Date.new(2022, 3, 1)
    )
    Timecop.freeze(Time.local(2023,3,21,9,30,00))
  end

  after do
    Timecop.return
  end

  it { should have_many :caretakers }

  describe '#caretaker' do
    it 'returns the first associated user' do
      expect(@rat.caretaker).to eq(@rat.caretakers.first)
    end
  end

  describe '#age' do
    context 'when crossed_rainbow_bridge' do
      it 'returns the age in months of the rat when it crossed the rainbow bridge' do
        expect(@rat.age).to eq(32)
      end
    end
    context 'when not crossed_rainbow_bridge' do
      it 'returns the current age in months of the rat' do
        expect(@rat2.age).to eq(12)
      end
    end
  end

  describe '#crossed_rainbow_bridge?' do
    it 'returns true iff crossed_rainbow_bridge_at is not nil' do
      expect(@rat.crossed_rainbow_bridge?).to eq(true)
      expect(@rat2.crossed_rainbow_bridge?).to eq(false)
    end
  end
end
