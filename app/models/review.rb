class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hike

  validates :rating, :content, presence: true
  validates :content, length: { minimum: 10 }
end
