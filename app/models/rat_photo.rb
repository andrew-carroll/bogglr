class RatPhoto < ApplicationRecord
  belongs_to :rat
  belongs_to :photo
  has_one_attached :image
end
