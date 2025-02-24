class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos, allow_destroy: true
  validates_presence_of :title, :description, :thumbnail

  def video_count
    videos.length
  end
end
