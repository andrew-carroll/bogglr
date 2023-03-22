require 'rails_helper'

RSpec.describe "Rats", type: :request do
  fixtures :users
  describe "GET /index" do
    it "returns http not found" do
      get "/rats"
      expect(response).to have_http_status(404)
    end
  end
  describe "GET /new" do
    context 'logged in' do
      before do
        login_as users(:acarroll)
      end
      it "returns http success" do
        get "/rats/new"
        expect(response).to have_http_status(:success)
      end
    end
    context 'not logged in' do
      it "redirects to sign in page" do
        get "/rats/new"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
