require 'rails_helper'

describe 'Homepage', type: :feature do
  before do
    @user = User.create!(
      username: "acarroll",
      email: "acarroll@bogglr.com",
      password: "hunter2",
      password_confirmation: "hunter2",
      confirmed_at: Time.now
    )
    @user2 = User.create!(
      username: "another_user",
      email: "another_user@bogglr.com",
      password: "hunter3",
      password_confirmation: "hunter3",
      confirmed_at: Time.now
    )
    photo_files = {
      ellie: fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'ellie.jpg')),
      honey: fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'honey.jpg')),
      fred_and_george: fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'fred_and_george.jpg')),
      gemma: fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'gemma.jpg')),
      linkin_and_blanche: fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'linkin_and_blanche.jpg'))
    }
    @rats = {
      ellie: @user.rats.create!(
        name: "Ellie",
        sex: :female,
        approx_birthday: Date.new(2018, 11, 1),
        crossed_rainbow_bridge_at: Date.new(2019, 12, 27)
      ),
      honey: @user.rats.create!(
        name: "Honey",
        sex: :female,
        approx_birthday: Date.new(2018, 11, 1),
        crossed_rainbow_bridge_at: Date.new(2020, 12, 31)
      ),
      fred: @user.rats.create!(
        name: "Fred",
        sex: :male,
        approx_birthday: Date.new(2018, 2, 1),
        crossed_rainbow_bridge_at: Date.new(2020, 10, 29)
      ),
      george: @user.rats.create!(
        name: "George",
        sex: :male,
        approx_birthday: Date.new(2018, 2, 1),
        crossed_rainbow_bridge_at: Date.new(2019, 12, 19)
      ),
      gemma: @user2.rats.create!(
        name: "Gemma",
        sex: :female,
        approx_birthday: Date.new(2022, 3, 1)
      ),
      linkin: @user2.rats.create!(
        name: "Linkin",
        sex: :male,
        approx_birthday: Date.new(2021, 5, 1)
      ),
      blanche: @user2.rats.create!(
        name: "Blanche",
        sex: :female,
        approx_birthday: Date.new(2022, 3, 1)
      )
   }

   [:ellie, :honey, :gemma].each do |rat|
     photo = @rats[rat].photos.create!(user: @rats[rat].caretakers.first)
     photo.image.attach(photo_files[rat])
   end

   photo = @rats[:linkin].photos.create!(user: @rats[:linkin].caretakers.first)
   RatPhoto.create!(rat: @rats[:blanche], photo: photo)
   photo.image.attach(photo_files[:linkin_and_blanche])

   photo = @rats[:fred].photos.create!(user: @rats[:fred].caretakers.first)
   RatPhoto.create!(rat: @rats[:george], photo: photo)
   photo.image.attach(photo_files[:fred_and_george])

   Timecop.freeze(Time.local(2023,3,21,9,30,00))
   visit root_path
  end

  after do
    Timecop.return
  end

  it 'should have a logo' do
    expect(page).to have_content("bogglr")
  end
  context 'when not logged in' do
    it 'should have links to sign up or sign in' do
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Sign in')
    end
  end
  context 'when logged in' do
    before do
      login_as @user
      visit root_path
    end
    it 'should have a link to log out and user profile' do
      expect(page).to have_link('My profile', href: user_profile_path)
      expect(page).to have_link('Sign out')
    end
  end
  describe 'feed' do
    it 'should display rat photos with names, birthdays, caretaker names, and crossed_rainbow_bridge status' do
      within(".feed .photo.photo_id_#{@rats[:george].photos.first.image.id}") do
        expect(page).to have_css('img[src*="' + @rats[:george].photos.first.image.filename.to_s + '"]')
        expect(page).to have_text(/^Fred and George, 32mo and 22mo 🌈 Caretaker: acarroll$/)
      end
      within(".feed .photo.photo_id_#{@rats[:ellie].photos.first.image.id}") do
        expect(page).to have_css('img[src*="' + @rats[:ellie].photos.first.image.filename.to_s + '"]')
        expect(page).to have_text(/^Ellie, 13mo 🌈 Caretaker: acarroll$/)
      end
      within(".feed .photo.photo_id_#{@rats[:honey].photos.first.image.id}") do
        expect(page).to have_css('img[src*="' + @rats[:honey].photos.first.image.filename.to_s + '"]')
        expect(page).to have_text(/^Honey, 25mo 🌈 Caretaker: acarroll$/)
      end
      within(".feed .photo.photo_id_#{@rats[:gemma].photos.first.image.id}") do
        expect(page).to have_css('img[src*="' + @rats[:gemma].photos.first.image.filename.to_s + '"]')
        expect(page).to have_text(/^Gemma, 12mo Caretaker: another_user$/)
      end
      within(".feed .photo.photo_id_#{@rats[:blanche].photos.first.image.id}") do
        expect(page).to have_css('img[src*="' + @rats[:linkin].photos.first.image.filename.to_s + '"]')
        expect(page).to have_text(/^Linkin and Blanche, 22mo and 12mo Caretaker: another_user$/)
      end
    end
  end
end
