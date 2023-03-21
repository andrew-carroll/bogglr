require 'rails_helper'

RSpec.describe RatPhoto, type: :model do
  it { should belong_to :rat }
  it { should belong_to :photo }
  it { should have_one_attached :image }
end
