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
  end
  it { should have_many :caretakers }
  describe '#caretaker' do
    it 'returns the first associated user' do
      expect(@rat.caretaker).to eq(@rat.caretakers.first)
    end
  end
end
