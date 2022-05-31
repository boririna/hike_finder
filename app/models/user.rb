class User < ApplicationRecord
  has_many :reviews
  has_many :likes
  has_many :hikes, through: :likes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
