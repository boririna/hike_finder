class Hike < ApplicationRecord
  LEVELS = ["easy", "medium", "hard", "experienced"]
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_one_attached :map_photo
  has_many_attached :photos

  validates :difficulty_level, inclusion: { in: LEVELS }

  reverse_geocoded_by :latitude, :longitude, :on => :near
  after_validation :reverse_geocode, :on => :near

  include PgSearch::Model
  pg_search_scope :search_name,
                  against: [ :name, :description, :services, :difficulty_level ],
                  order_within_rank: "hikes.created_at DESC",
                  using: { tsearch: { dictionary: 'german' } }
end
