class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_presence_of :title, :description, :video_id, :thumbnail

  after_create :check_position

  private
  def check_position
    if self.position == 0
      self.update_attribute(:position, self.tutorial.video_count)
    end
  end
end
