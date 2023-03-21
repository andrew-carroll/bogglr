class RatUser < ApplicationRecord
  belongs_to :rat
  belongs_to :user
end
