require 'rails_helper'

RSpec.feature "UserProfiles", type: :feature do
  before do
    @user = User.create!(username: 'acarroll', email: 'acarroll@bogglr.com', password: 'hunter2', password_confirmation: 'hunter2')
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
    login_as @user
    visit user_profile_path
  end
  it 'has a link to new rat creation page' do
    expect(page).to have_link('Add a rat', href: '/rat/new')
  end
  it 'lists all rats for whom the user is a caretaker' do
    within '.rats' do
      expect(page).to have_link('Fred', href: "/rat.#{@rat.id}")
      expect(page).to have_link('Gemma', href: "/rat.#{@rat2.id}")
    end
  end
end
