class Like < ApplicationRecord
  belongs_to :user
  belongs_to :hike

  validates :user, uniqueness: { scope: :hike }
end
