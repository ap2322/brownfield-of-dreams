class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  def validate_friend
    User.ids.include?(friend_id)
  end
end
