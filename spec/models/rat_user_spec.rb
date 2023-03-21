require 'rails_helper'

RSpec.describe RatUser, type: :model do
  it { should belong_to :user }
  it { should belong_to :rat }
end
