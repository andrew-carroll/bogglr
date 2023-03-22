require 'rails_helper'

describe 'New rat page', type: :feature do
  fixtures :rats, :users, :rat_users
  context 'when logged in' do
    before do
      login_as users(:ellie_fred_george_honey_caretaker)
      visit new_rat_path
    end
    context 'filling in all form fields' do
      it 'should redirect to the newly created rat page' do
        within('form') do
          fill_in 'rat_name', with: 'Regina'
          select 'Female', from: 'rat_sex'
          select '2018', from: 'rat[approx_birthday(1i)]'
          select 'March', from: 'rat[approx_birthday(2i)]'
          select '15', from: 'rat[approx_birthday(3i)]'
          select '2019', from: 'rat[crossed_rainbow_bridge_at(1i)]'
          select 'March', from: 'rat[crossed_rainbow_bridge_at(2i)]'
          select '15', from: 'rat[crossed_rainbow_bridge_at(3i)]'
          click_on "Save"
        end
        expect(page).to have_text("Regina")
      end
    end
    context 'filling in no form fields'
    context 'filling in future approx_birthday'
  end
end
