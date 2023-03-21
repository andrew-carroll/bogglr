require 'rails_helper'

RSpec.describe "UserProfiles", type: :request do
  describe "GET /index" do
    context 'logged in' do
      before do
        @user = User.create!(username: 'acarroll', email: 'acarroll@bogglr.com', password: 'hunter2', password_confirmation: 'hunter2')
        login_as @user
      end
      it "returns http success" do
        get "/user_profiles/index"
        expect(response).to have_http_status(:success)
      end
    end
    context "not logged in" do
      it "redirects to sign in page" do
        get "/user_profiles/index"
        expect(response).to have_http_status(302)
      end
    end
  end

end
