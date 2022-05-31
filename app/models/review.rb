class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hike

  validates :rating, :content, presence: true
  validates :content, length: { minimum: 10 }

  def average_rating(hike)
    Review.where(hike_id: hike.id).average(:rating).to_i
  end

end
