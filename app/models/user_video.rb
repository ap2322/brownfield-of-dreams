class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: "video_id"
  belongs_to :user, foreign_key: "user_id"

  def self.tutorial_sort
    joins(video: :tutorial).order('videos.tutorial_id').select('user_videos.*, videos.tutorial_id, tutorials.title as tutorial_title')
  end
end
