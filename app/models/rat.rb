class Rat < ApplicationRecord
  has_many :rat_users
  has_many :caretakers, through: :rat_users, source: :user
  has_many :rat_photos
  has_many :photos, through: :rat_photos

  def caretaker
    caretakers.first
  end

  def age
    if crossed_rainbow_bridge?
      ((crossed_rainbow_bridge_at - approx_birthday) / 1.month).to_i
    else
      ((Time.now - approx_birthday) / 1.month).to_i
    end
  end

  def crossed_rainbow_bridge?
    crossed_rainbow_bridge_at != nil
  end
end
