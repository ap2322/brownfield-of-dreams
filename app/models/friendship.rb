class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  def validate_friend
    User.ids.include?(friend_id)
  end

  def github_connection?(user, friend_id)
    friend = User.find(friend_id)
    user.user_followers.include?(friend.username) || user.user_followings.include?(friend.username)
  end
end
