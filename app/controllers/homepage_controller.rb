class HomepageController < ApplicationController
  def index
    @photos = Photo.includes(rats: [:caretakers]).order(created_at: :desc).all
  end
end
