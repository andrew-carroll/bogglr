class Photo < ApplicationRecord
  belongs_to :user
  has_many :rat_photos
  has_many :rats, through: :rat_photos
  has_one_attached :image
end
