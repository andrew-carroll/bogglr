class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    @rats = current_user.rats
  end
end
