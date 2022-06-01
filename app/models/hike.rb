class Hike < ApplicationRecord
  LEVELS = ["easy", "medium", "hard", "experienced"]
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many_attached :photos

  validates :difficulty_level, inclusion: { in: LEVELS }
end
