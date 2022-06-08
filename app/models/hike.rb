class Hike < ApplicationRecord
  LEVELS = ["easy", "medium", "hard", "experienced"]
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_one_attached :map_photo
  has_many_attached :photos

  validates :difficulty_level, inclusion: { in: LEVELS }

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
