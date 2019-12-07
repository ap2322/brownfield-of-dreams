class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password
end
