require 'rails_helper'

RSpec.feature "UserProfiles", type: :feature do
  fixtures :rats, :users
  before do
    login_as users(:acarroll)
    visit user_profile_path
  end
  it 'has a link to new rat creation page' do
    expect(page).to have_link('Add a rat', href: '/rats/new')
  end
  it 'lists all rats for whom the user is a caretaker' do
    within '.rats' do
      expect(page).to have_link('Fred', href: "/rats/#{rats(:fred).id}")
      expect(page).to have_link('George', href: "/rats/#{rats(:george).id}")
      expect(page).to have_link('Honey', href: "/rats/#{rats(:honey).id}")
      expect(page).to have_link("Ellie", href: "/rats/#{rats(:ellie).id}")
    end
  end
end
