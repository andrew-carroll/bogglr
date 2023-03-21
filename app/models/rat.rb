class Rat < ApplicationRecord
  has_many :rat_users
  has_many :caretakers, through: :rat_users, source: :user
  has_many :rat_photos
  has_many :photos, through: :rat_photos

  def caretaker
    caretakers.first
  end
end
